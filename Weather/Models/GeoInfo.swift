//
//  GeoInfo.swift
//  Weather
//
//  Created by Alexander Pelevinov on 15.07.2021.
//

import Foundation

struct GeoInfo: Hashable {
    let cityName: String
}

extension GeoInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case cityName = "locality"

        enum NameKeys: String, CodingKey {
            case nameKey = "name"
        }
    }

    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameKeys.self, forKey: .cityName)
        cityName = try nameContainer.decode(String.self, forKey: .nameKey)
        }
}

