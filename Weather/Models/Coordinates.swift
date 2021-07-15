//
//  City.swift
//  Weather
//
//  Created by Alexander Pelevinov on 14.07.2021.
//

import Foundation

struct Coordinates: Hashable {
    let lat: Double
    let lon: Double
}

extension Coordinates: Decodable {
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }
}



