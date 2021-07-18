//
//  NameToCoordinatesTransformer.swift
//  Weather
//
//  Created by Alexander Pelevinov on 15.07.2021.
//

import Foundation

protocol NameToCoordinatesTransformer {
    func getCoordinates(by name: String,
                        completion: @escaping (Result<Coordinates, Error>) -> Void)
}
