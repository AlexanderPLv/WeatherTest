//
//  Networkable.swift
//  Weather
//
//  Created by Alexander Pelevinov on 15.07.2021.
//

import Foundation

protocol Networkable {
    var session : URLSession! { get }
    func weatherRequest(for cities: [CityInfo],
                        completion: @escaping ([CityInfo]) -> Void)
}

extension Networkable {
    
    func request(with coordinates: Coordinates,
                         completion: @escaping (Result<CityInfo, Error>) -> Void) {
        do {
            guard let request = try? self.buildRequest(with: coordinates) else { throw NetworkingError.invalidRequest }
          //  log(request: request)
            let task = session.dataTask(with: request, completionHandler: {
                (data: Data?, response: URLResponse?, error: Error?) -> Void in
                self.log(data: data, response: response as? HTTPURLResponse, error: error)
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
       
        
    fileprivate func log(request: URLRequest){

        let urlString = request.url?.absoluteString ?? ""
        let components = NSURLComponents(string: urlString)

        let method = request.httpMethod != nil ? "\(request.httpMethod!)": ""
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        let host = "\(components?.host ?? "")"

        var requestLog = "\n---------- OUT ---------->\n"
        requestLog += "\(urlString)"
        requestLog += "\n\n"
        requestLog += "\(method) \(path)?\(query) HTTP/1.1\n"
        requestLog += "Host: \(host)\n"
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            requestLog += "\(key): \(value)\n"
        }
        if let body = request.httpBody{
            let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body; not utf8 encoded";
            requestLog += "\n\(bodyString)\n"
        }

        requestLog += "\n------------------------->\n";
        print(requestLog)
    }
    
    fileprivate func log(data: Data?, response: HTTPURLResponse?, error: Error?){

        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")

        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"

        var responseLog = "\n<---------- IN ----------\n"
        if let urlString = urlString {
            responseLog += "\(urlString)"
            responseLog += "\n\n"
        }

        if let statusCode =  response?.statusCode{
            responseLog += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host{
            responseLog += "Host: \(host)\n"
        }
        for (key,value) in response?.allHeaderFields ?? [:] {
            responseLog += "\(key): \(value)\n"
        }
        if let body = data{
            let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body; not utf8 encoded";
            responseLog += "\n\(bodyString)\n"
        }
        if let error = error{
            responseLog += "\nError: \(error.localizedDescription)\n"
        }

        responseLog += "<------------------------\n";
        print(responseLog)
    }
    
}
