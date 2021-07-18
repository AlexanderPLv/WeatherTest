//
//  Weather.swift
//  Weather
//
//  Created by Alexander Pelevinov on 14.07.2021.
//

import Foundation

struct WeatherInfo: Hashable {
    let temp: Int
    let condition: Condition
    let feelsLike: Int
    let wind: Double
    let humidity: Double
    let pressure: Double
}

extension WeatherInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case temp
        case condition
        case feelsLike = "feels_like"
        case wind = "wind_speed"
        case humidity
        case pressure = "pressure_mm"
    }
}
