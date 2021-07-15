//
//  NameToCoordinatesTransformer.swift
//  Weather
//
//  Created by Alexander Pelevinov on 15.07.2021.
//

import Foundation

protocol CityNameToCoordinatesTransformer {
    func getCoordinates(by name: String) -> Coordinates
}
