//
//  NetworkService.swift
//  Weather
//
//  Created by Alexander Pelevinov on 13.07.2021.
//

import Foundation

class NetworkService: Networkable {
    
    var session: URLSession!
    let dispatchGroup = DispatchGroup()
    let dispatchQueue = DispatchQueue(label: "NetworkQueue")
    
    
    class func configureNetworkService() -> Networkable {
    let service = NetworkService()
        service.session = URLSession.shared
        return service
    }
    
    func weatherRequest(for cities: [CityInfo],
                        completion: @escaping ([CityInfo]) -> Void) {
        var response = [CityInfo]()
        cities.forEach { [weak self] city in
            dispatchGroup.enter()
            request(with: city.coordinates) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    response.append(weather)
                case.failure(_):
                    let mockObject = CityInfo.mock(with: city.geoInfo.cityName)
                    response.append(mockObject)
                }
                self.dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: dispatchQueue) {
            completion(response)
        }
    }
    
}
