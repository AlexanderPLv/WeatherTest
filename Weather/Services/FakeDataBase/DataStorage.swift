//
//  DataStorage.swift
//  Weather
//
//  Created by Alexander Pelevinov on 15.07.2021.
//

import Foundation

protocol DataStorage {
    func getListOfFavoritesCity() -> [CityInfo]
    func saveListOfFavoritesCity(_ data: [CityInfo])
    func remove(_ city: CityInfo)
    func append(_ city: CityInfo)
}
