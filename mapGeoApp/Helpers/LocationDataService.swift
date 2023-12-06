//
//  LocationDataService.swift
//  mapGeoApp
//
//  Created by Аня Воронцова on 06.12.2023.
//

import Foundation
import MapKit

final class LocationDataService {
    static let currentLocation = CurrentUserLocation(name: "me",
                                              imageName: ImageNameConstant.myLocation,
                                              location: CLLocationCoordinate2D())
    static let mockLocations : [Location] = [
        Location(
            name: "me",
            imageName: ImageNameConstant.myTracker,
            lastSeenDate: "04.12.23",
            lastSeenTime: "15:00",
            location: CLLocationCoordinate2D()
        ),
        Location(
            name: "Дядя Борис",
            imageName: FriendPhoto.uncleBorya,
            lastSeenDate: "04.12.23",
            lastSeenTime: "15:00",
            location: CLLocationCoordinate2D()
        ),
        Location(
            name: "Ленка",
            imageName: FriendPhoto.lenka,
            lastSeenDate: "04.12.23",
            lastSeenTime: "15:00",
            location: CLLocationCoordinate2D()
        ),
        Location(
            name: "Оля Дизайнер",
            imageName: FriendPhoto.olyaDesigner,
            lastSeenDate: "04.12.23",
            lastSeenTime: "15:00",
            location: CLLocationCoordinate2D()
        ),
        Location(
            name: "Леша ремонт",
            imageName: FriendPhoto.leshaRemont,
            lastSeenDate: "04.12.23",
            lastSeenTime: "15:00",
            location: CLLocationCoordinate2D()
        ),
        Location(
            name: "Андрей Семенов",
            imageName: FriendPhoto.andrewSemenov,
            lastSeenDate: "04.12.23",
            lastSeenTime: "15:00",
            location: CLLocationCoordinate2D()
        ),
        Location(
            name: "Катя",
            imageName: FriendPhoto.katya,
            lastSeenDate: "04.12.23",
            lastSeenTime: "15:00",
            location: CLLocationCoordinate2D()
        )
    ]
}
