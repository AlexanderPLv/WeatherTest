//
//  DataManager.swift
//  Weather
//
//  Created by Alexander Pelevinov on 15.07.2021.
//

import Foundation

protocol WeatherDataProvider {
    func getWeatherData(completion: @escaping ([CityInfo]) -> Void)
}

class DataManager: WeatherDataProvider {
    
    private var networkService: Networkable!
    private var dataStorage: DataStorage!
    
    class func configureDataManager() -> WeatherDataProvider {
        let service = DataManager()
        service.dataStorage = FakeDB()
        service.networkService = NetworkService.configureNetworkService()
        return service
    }
    
    func getWeatherData(completion: @escaping ([CityInfo]) -> Void) {
        let cities = dataStorage.getListOfFavoritesCity()
        networkService.weatherRequest(for: cities) { [weak self] result in
            guard let self = self else { return }
            self.dataStorage.saveListOfFavoritesCity(result)
            let data = self.dataStorage.getListOfFavoritesCity()
            completion(data)
        }
    
    }
    
    
    
}
