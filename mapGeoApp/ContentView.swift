//
//  ContentView.swift
//  mapGeoApp
//
//  Created by Аня Воронцова on 04.12.2023.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject var vm = ContentViewModel()
    @State private var showBottomSheet = false
    @State private var mapRegion = MKCoordinateRegion()
    @State private var pinTapped = FriendLocation(name: "", imageName: "", lastSeenDate: "§", lastSeenTime: "", location: CLLocationCoordinate2D())
    
    var body: some View {
        Map(coordinateRegion: $mapRegion, showsUserLocation: true, annotationItems: vm.mockLocations) { loc in
            MapAnnotation(coordinate: loc.location) {
                ZStack {
                    Image(ImageNameConstant.tracker)
                        .resizable()
                        .frame(width: 100, height:  100)
                    Image(loc.imageName)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(60)
                        .frame(width: 70,
                               height: 70)
                        .clipped()
                        .padding(.bottom, 15)
                }
                .onTapGesture {
                    showBottomSheet.toggle()
                    vm.pinButtonTapped(loc: loc)
                    print("PinTapped", showBottomSheet, pinTapped)
                }
            }
        }
        .onReceive(vm.$mapRegion, perform: { _ in
            mapRegion = vm.mapRegion
        })
        .onReceive(vm.$pinTapped, perform: { _ in
            pinTapped = vm.pinTapped
        })
        .ignoresSafeArea()
        .sheet(isPresented: $showBottomSheet) {
            VStack {
                Text(pinTapped.imageName)
            }
        }
        
        .onAppear(perform: vm.checkIfLocationServicesAreEnabled)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: ContentView.ContentViewModel())
    }
}

extension ContentView {
    final class ContentViewModel : NSObject, ObservableObject, CLLocationManagerDelegate {
        
        var locationManager : CLLocationManager?
        
        func checkIfLocationServicesAreEnabled() {
            DispatchQueue.global().async {
                if CLLocationManager.locationServicesEnabled() {
                    self.locationManager = CLLocationManager()
                    self.locationManager?.delegate = self
                } else {
                    //TODO: запросить включение локации
                }
            }
        }
        
        private func checkLocationAuthorization() {
            guard let locationManager = locationManager else { return }
            
            switch locationManager.authorizationStatus {
                
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("")
            case .denied:
                print("")
            case .authorizedAlways, .authorizedWhenInUse:
                mapRegion = MKCoordinateRegion(center:  locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30),
                                               span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            @unknown default:
                break
            }
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkLocationAuthorization()
        }
        
        @Published var mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        @Published var showBottomSheet = false
        @Published var pinTapped : FriendLocation = FriendLocation(name: "", imageName: "", lastSeenDate: "", lastSeenTime: "", location: CLLocationCoordinate2D())
        
        let mockLocations : [FriendLocation] = [
            FriendLocation(
                name: "Дядя Борис",
                imageName: FriendPhoto.uncleBorya,
                lastSeenDate: "04.12.23",
                lastSeenTime: "15:00",
                location: CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30)
            ),
            FriendLocation(
                name: "Ленка",
                imageName: FriendPhoto.lenka,
                lastSeenDate: "04.12.23",
                lastSeenTime: "15:00",
                location: CLLocationCoordinate2D(latitude: 59.937, longitude: 30.309)
            ),
            FriendLocation(
                name: "Оля Дизайнер",
                imageName: FriendPhoto.olyaDesigner,
                lastSeenDate: "04.12.23",
                lastSeenTime: "15:00",
                location: CLLocationCoordinate2D(latitude: 59.94, longitude: 30.31)
            ),
            FriendLocation(
                name: "Леша ремонт",
                imageName: FriendPhoto.leshaRemont,
                lastSeenDate: "04.12.23",
                lastSeenTime: "15:00",
                location: CLLocationCoordinate2D(latitude: 59.94, longitude: 30.3101)
            ),
            FriendLocation(
                name: "Андрей Семенов",
                imageName: FriendPhoto.andrewSemenov,
                lastSeenDate: "04.12.23",
                lastSeenTime: "15:00",
                location: CLLocationCoordinate2D(latitude: 59.939, longitude: 30.30989)
            ),
            FriendLocation(
                name: "Катя",
                imageName: FriendPhoto.katya,
                lastSeenDate: "04.12.23",
                lastSeenTime: "15:00",
                location: CLLocationCoordinate2D(latitude: 59.921, longitude: 30.318)
            )
        ]
        
        func pinButtonTapped(loc : FriendLocation) {
            pinTapped = loc
        }
        
    }
}
