//
//  ContentView.swift
//  mapGeoApp
//
//  Created by Аня Воронцова on 04.12.2023.
//

import MapKit
import SwiftUI

struct MainMapView: View {
    @StateObject var locationManager = LocationManager()
    @EnvironmentObject var vm : MainMapViewModel
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $locationManager.mapRegion,
                showsUserLocation: true,
                annotationItems: vm.locations) { loc in
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
                        vm.showBottomSheet.toggle()
                        vm.pinButtonTapped(loc: loc)
                        locationManager.showNextLocation(for: loc.location)
                    }
                }
            }
                .ignoresSafeArea()
                .sheet(isPresented: $vm.showBottomSheet) {
                    SheetView(friendTapped: vm.pinTapped)
                        .presentationDetents([.height(200)])
                }
                .onAppear {
                    locationManager.makeLocationManager()
                    vm.locations = vm.generateMocLocations(for: locationManager.locationManager?.location?.coordinate ?? locationManager.mapRegion.center)
                }
            MenuView(locationManager: locationManager, locations: $vm.locations)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView()
            .environmentObject(MainMapViewModel())
    }
}
