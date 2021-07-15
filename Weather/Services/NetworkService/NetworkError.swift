//
//  NetworkError.swift
//  Weather
//
//  Created by Alexander Pelevinov on 14.07.2021.
//

import Foundation

enum NetworkingError: String, Error {
    case invalidRequest = "Enable to build request."
    case parsingError = "Parsing error."
    case missingURL = "Missing URL."
    case badData = "Bad data."
}
extension NetworkingError: LocalizedError {
    var errorDescription: String? { return NSLocalizedString(rawValue, comment: "")}
}
