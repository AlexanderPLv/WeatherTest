//
//  Condition.swift
//  Weather
//
//  Created by Alexander Pelevinov on 14.07.2021.
//

import Foundation

enum Condition : String, Codable, Hashable {
    case clear                  = "clear"
    case partlyCloudy           = "partly-cloudy"
    case cloudy                 = "cloudy"
    case overcast               = "overcast"
    case drizzle                = "drizzle"
    case lightRain              = "light-rain"
    case rain                   = "rain"
    case moderateRain           = "moderate-rain"
    case heavyRain              = "heavy-rain"
    case continuousHeavyRain    = "continuous-heavy-rain"
    case showers                = "showers"
    case wetSnow                = "wet-snow"
    case lightSnow              = "light-snow"
    case snow                   = "snow"
    case snowShowers            = "snow-showers"
    case hail                   = "hail"
    case thunderstorm           = "thunderstorm"
    case thunderstormWithRain   = "thunderstorm-with-rain"
    case thunderstormWithHail   = "thunderstorm-with-hail"
    case none                   = "none"
}
