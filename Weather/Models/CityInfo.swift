//
//  Response.swift
//  Weather
//
//  Created by Alexander Pelevinov on 14.07.2021.
//

import Foundation

struct CityInfo: Hashable {
    static func == (lhs: CityInfo, rhs: CityInfo) -> Bool {
        lhs.geoInfo.cityName == rhs.geoInfo.cityName
    }
    
    let coordinates: Coordinates
    let weather: WeatherInfo
    let geoInfo: GeoInfo
}

extension CityInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case coordinates = "info"
        case weather = "fact"
        case geoInfo = "geo_object"
    }
}
