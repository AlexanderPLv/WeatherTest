//
//  DataManager.swift
//  Weather
//
//  Created by Alexander Pelevinov on 15.07.2021.
//

import Foundation

protocol ForecastProvider {
    func getForecast(completion: @escaping ([CityInfo]) -> Void)
    func getForecast(by cityName: String, completion: @escaping (Result<CityInfo, Error>) -> Void)
    func removeCity(_ city: CityInfo)
    func append(_ city: CityInfo)
}

class DataManager: ForecastProvider {
    
    private var networkService: Networkable!
    private var dataStorage: DataStorage!
    private var geocoder: NameToCoordinatesTransformer!
    
    class func configureDataManager() -> ForecastProvider {
        let service = DataManager()
        service.dataStorage = FakeDB()
        service.geocoder = Geocoder.configureGeocoder()
        service.networkService = NetworkService.configureNetworkService()
        return service
    }
    
    func append(_ city: CityInfo) {
        dataStorage.append(city)
    }
    
    func removeCity(_ city: CityInfo) {
        dataStorage.remove(city)
    }
    
    func getForecast(completion: @escaping ([CityInfo]) -> Void) {
        let cities = dataStorage.getListOfFavoritesCity()
        networkService.forecastRequest(for: cities) { [weak self] result in
            guard let self = self else { return }
            self.dataStorage.saveListOfFavoritesCity(result)
            let data = self.dataStorage.getListOfFavoritesCity()
            completion(data)
        }
    }
    
    func getForecast(by cityName: String,
                     completion: @escaping (Result<CityInfo, Error>) -> Void) {
        geocoder.getCoordinates(by: cityName) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let coordinates):
                self.networkService.forecastRequest(by: coordinates) { result in
                    switch result {
                    case .success(let weatherData):
                        completion(.success(weatherData))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
