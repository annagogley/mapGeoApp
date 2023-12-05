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
    
    func location(currentLocation : CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let lat = currentLocation.latitude + Double(arc4random()) / 1000
        let long = currentLocation.longitude + Double(arc4random()) / 1000
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
