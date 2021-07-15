//
//  Weather.swift
//  Weather
//
//  Created by Alexander Pelevinov on 14.07.2021.
//

import Foundation

struct WeatherInfo: Decodable, Hashable {
    let temp: Int
    let condition: Condition
}
