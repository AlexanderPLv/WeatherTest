//
//  Networkable.swift
//  Weather
//
//  Created by Alexander Pelevinov on 15.07.2021.
//

import Foundation

protocol Networkable {
    var session : URLSession! { get }
    func forecastRequest(for cities: [CityInfo],
                         completion: @escaping ([CityInfo]) -> Void)
    func forecastRequest(by coordinates: Coordinates,
                         completion: @escaping (Result<CityInfo, Error>) -> Void)
}

extension Networkable {
    
    func request(with coordinates: Coordinates,
                 completion: @escaping (Result<CityInfo, Error>) -> Void) {
        do {
            guard let request = try? self.buildRequest(with: coordinates) else { throw NetworkingError.invalidRequest }
            let task = session.dataTask(with: request, completionHandler: {
                (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if let error = error {
                    completion(.failure(error))
                }
                guard let data = data else {
                    completion(.failure(NetworkingError.badData))
                    return
                }
                do {
                    let value = try self.decode(data)
                    completion(.success(value))
                } catch {
                    completion(.failure(NetworkingError.parsingError))
                }
            })
            task.resume()
        } catch let error {
            completion(.failure(error))
        }
    }
    
    private func buildRequest(with coordinates: Coordinates) throws -> URLRequest {
        let lat = String(coordinates.lat)
        let lon = String(coordinates.lon)
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.weather.yandex.ru"
        components.path = "/v2/forecast"
        components.queryItems = [
            URLQueryItem(name: "limit", value: "1"),
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "lang", value: "en_US"),
        ]
        guard let url = components.url else { throw NetworkingError.missingURL }
        
        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 20.0)
        request.httpMethod = "GET"
        request.setValue("cfc600f4-cefe-4a1c-b85c-a79b3919e6b6", forHTTPHeaderField: "X-Yandex-API-Key")
        return request
    }
    
    private func decode(_ data: Data) throws -> CityInfo {
        let decoder = JSONDecoder()
        let value = try decoder.decode(CityInfo.self, from: data)
        return value
    }
}
