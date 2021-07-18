//
//  Geocoder.swift
//  Weather
//
//  Created by Alexander Pelevinov on 13.07.2021.
//

import Foundation
import CoreLocation

class Geocoder: NameToCoordinatesTransformer {
    private var geocoder: CLGeocoder!
    
    class func configureGeocoder() -> NameToCoordinatesTransformer {
        let service = Geocoder()
        let geocoder = CLGeocoder()
        service.geocoder = geocoder
        return service
    }
    
    func getCoordinates(by name: String,
                        completion: @escaping (Result<Coordinates, Error>) -> Void) {
        geocoder.geocodeAddressString(name) { placemarks, error in
            if let error = error {
                completion(.failure(error))
            }
                guard let placemark = placemarks?[0],
                      let location = placemark.location else {
                    return
                }
                let coordinates = Coordinates(lat: location.coordinate.latitude,
                                              lon: location.coordinate.longitude)
                completion(.success(coordinates))
    }
}
    
}
