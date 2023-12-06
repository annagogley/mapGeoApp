//
//  СщтеутеМшуцЬщвуд.swift
//  mapGeoApp
//
//  Created by Аня Воронцова on 06.12.2023.
//

import Foundation
import MapKit

final class MainMapViewModel : ObservableObject {
    
    @Published var showBottomSheet = false
    @Published var pinTapped : Location = Location(name: "", imageName: "", lastSeenDate: "", lastSeenTime: "", location: CLLocationCoordinate2D())
    @Published var locations = [Location]()
    
    
//    init() {
//        self.locations = LocationDataService.mockLocations
//    }
    
    func pinButtonTapped(loc : Location) {
        pinTapped = loc
    }
    
    func generateMocLocations(for location : CLLocationCoordinate2D) -> [Location] {
        locations = [
            Location(
                name: "Дядя Борис",
                imageName: FriendPhoto.uncleBorya,
                lastSeenDate: "04.12.23",
                lastSeenTime: "15:00",
                location: GetRandom.shared.location(currentLocation: location)
            ),
            Location(
                name: "Ленка",
                imageName: FriendPhoto.lenka,
                lastSeenDate: "04.12.23",
                lastSeenTime: "15:00",
                location: GetRandom.shared.location(currentLocation: location)
            ),
            Location(
                name: "Оля Дизайнер",
                imageName: FriendPhoto.olyaDesigner,
                lastSeenDate: "04.12.23",
                lastSeenTime: "15:00",
                location: GetRandom.shared.location(currentLocation: location)
            ),
            Location(
                name: "Леша ремонт",
                imageName: FriendPhoto.leshaRemont,
                lastSeenDate: "04.12.23",
                lastSeenTime: "15:00",
                location: GetRandom.shared.location(currentLocation: location)
            ),
            Location(
                name: "Андрей Семенов",
                imageName: FriendPhoto.andrewSemenov,
                lastSeenDate: "04.12.23",
                lastSeenTime: "15:00",
                location: GetRandom.shared.location(currentLocation: location)
            ),
            Location(
                name: "Катя",
                imageName: FriendPhoto.katya,
                lastSeenDate: "04.12.23",
                lastSeenTime: "15:00",
                location: GetRandom.shared.location(currentLocation: location)
            )
        ]
        return locations
    }
}
