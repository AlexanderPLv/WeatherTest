//
//  MockCityForecast.swift
//  Weather
//
//  Created by Alexander Pelevinov on 15.07.2021.
//

import Foundation

extension CityInfo {
    static func mock(with name: String, lat: Double = 0.0, lon: Double =  0.0) -> CityInfo {
        let coordinates = Coordinates(lat: lat, lon: lon)
        let weatherInfo = WeatherInfo(temp: 404, condition: .none)
        let geoInfo = GeoInfo(cityName: name)
        let mockForecast = CityInfo(coordinates: coordinates, weather: weatherInfo, geoInfo: geoInfo)
        return mockForecast
    }
}
