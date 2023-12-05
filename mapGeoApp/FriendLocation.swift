//
//  ChildLocation.swift
//  mapGeoApp
//
//  Created by Аня Воронцова on 04.12.2023.
//

import Foundation
import MapKit

struct FriendLocation : Identifiable {
    let id = UUID()
    let name : String
    let imageName : String
    let lastSeenDate: String
    let lastSeenTime : String
    let location : CLLocationCoordinate2D
}
