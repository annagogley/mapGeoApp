//
//  LocationManager.swift
//  mapGeoApp
//
//  Created by Аня Воронцова on 05.12.2023.
//

import Foundation
import MapKit
import SwiftUI

final class LocationManager : NSObject, ObservableObject {
    
    @Published var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @Published var mapLocation : CLLocationCoordinate2D {
        didSet {
            updateMapRegion(for: mapLocation)
        }
    }
    @Published var lastLocation : CLLocationCoordinate2D?
    var currentIndex = 0
    
    //для отслеживания геолокации пользователя
    var locationManager : CLLocationManager?
    
    override init() {
        mapLocation = CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30)
    }
    
    func makeLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.updateMapRegion(for: locationManager?.location?.coordinate ?? CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30))
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Вы отключили службу геолокации.")
        case .authorizedAlways, .authorizedWhenInUse:
            mapRegion = MKCoordinateRegion(center:  locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30),
                                           span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            mapLocation = mapRegion.center
            lastLocation = mapRegion.center
        @unknown default:
            break
        }
    }
    
    func updateMapRegion(for location : CLLocationCoordinate2D) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        }
    }
    
    func showNextLocation(for location : CLLocationCoordinate2D) {
        withAnimation(.easeInOut) {
            mapLocation = location
        }
    }
    
    func zoomIn() {
        mapRegion.span.longitudeDelta *= 0.5
        mapRegion.span.latitudeDelta *= 0.5
    }
    
    func zoomOut() {
        mapRegion.span.longitudeDelta /= 0.5
        mapRegion.span.latitudeDelta /= 0.5
    }
    
    func showFriendLocation(locations : [Location]) {
        guard currentIndex < locations.count else {
            currentIndex = 0
            if let firstLocation = locations.first {
                showNextLocation(for: firstLocation.location)
            }
            return
        }
        showNextLocation(for: locations[currentIndex].location)
        currentIndex += 1
    }
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location.coordinate
        print(#function, location)
    }
}
