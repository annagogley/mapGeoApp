//
//  MenuView.swift
//  mapGeoApp
//
//  Created by Аня Воронцова on 06.12.2023.
//

import Foundation
import SwiftUI
import CoreLocation

//Боковое меню для зума/поиска друзей/поиска себя на карте

struct MenuView : View {
    @StateObject var locationManager = LocationManager()
    @State var locations : [Location]

    var body : some View {
        HStack {
            Spacer()
            VStack {
                Button {
                    withAnimation(.easeInOut) {
                        locationManager.zoomIn()
                    }
                } label: {
                    Image(ImageNameConstant.zoomPlus)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Button {
                    withAnimation(.easeInOut) {
                        locationManager.zoomOut()
                    }
                } label: {
                    Image(ImageNameConstant.zoomMinus)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Button {
                    locationManager.showNextLocation(for: locationManager.lastLocation ?? CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30))
                } label: {
                    Image(ImageNameConstant.myLocation)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Button {
                    locationManager.showFriendLocation(locations: locations)
                } label: {
                    Image(ImageNameConstant.nextTracker)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
        }
    }
}
