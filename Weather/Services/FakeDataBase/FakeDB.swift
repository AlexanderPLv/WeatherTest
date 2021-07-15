//
//  FakeDB.swift
//  Weather
//
//  Created by Alexander Pelevinov on 14.07.2021.
//

import Foundation

class FakeDB: DataStorage {
    
    private let queue = DispatchQueue(label: "db-access",
                                      attributes: .concurrent)
    
    private var listOfFavoritesCity: Set<CityInfo> = [
        CityInfo.mock(with: "Moscow", lat: 55.7558, lon: 37.6173),
        CityInfo.mock(with: "Saint Petersburg", lat: 59.937500, lon: 30.308611),
        CityInfo.mock(with: "Novosibirsk", lat: 54.9833, lon: 82.8964),
        CityInfo.mock(with: "Perm", lat: 58.0092, lon: 56.2270),
        CityInfo.mock(with: "Krasnodar", lat: 45.0360, lon: 38.9746),
        CityInfo.mock(with: "Tomsk", lat: 56.4884, lon: 84.9480),
        CityInfo.mock(with: "Ufa", lat: 54.7348, lon: 55.9579),
        CityInfo.mock(with: "Magadan", lat: 59.5594, lon: 150.8128),
        CityInfo.mock(with: "Yuzhno-Sakhalinsk", lat: 46.9641, lon: 142.7285),
        CityInfo.mock(with: "Kazan", lat: 55.7879, lon: 49.1233),
    ]
    
    func getListOfFavoritesCity() -> [CityInfo] {
        var list = [CityInfo]()
        queue.sync {
            list = Array(listOfFavoritesCity)
        }
        return list
    }
    
    func saveListOfFavoritesCity(_ data: [CityInfo]) {
        queue.async(flags: .barrier) {
            self.listOfFavoritesCity = Set(data.map { $0 })
        }
    }
}
