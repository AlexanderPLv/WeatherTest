//
//  DetailTableTitles.swift
//  Weather
//
//  Created by Alexander Pelevinov on 18.07.2021.
//

import UIKit

struct DetailTableParameters {
    
    static let rowHeight: CGFloat = 50
    static let headerHeight: CGFloat = 250
    static let titles: [DetailCellTitles] = [
        .feelsLike,
        .wind,
        .humidity,
        .pressure,
    ]
}

enum DetailCellTitles: String {
        case feelsLike = "FEELS LIKE"
        case wind = "WIND"
        case humidity = "HUMIDITY"
        case pressure = "PRESSURE"
    }
