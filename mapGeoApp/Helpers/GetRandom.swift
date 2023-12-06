//
//  GetRandom.swift
//  mapGeoApp
//
//  Created by Аня Воронцова on 04.12.2023.
//

import Foundation
import MapKit

final class GetRandom {
    static let shared = GetRandom()
    
    //рандомная локация для друзей рядом с текущей локацией
    func location(currentLocation : CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let lat = currentLocation.latitude + Double.random(in: -100...100) / 1000
        let long = currentLocation.longitude + Double.random(in: -100...100) / 1000
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
