//
//  mapGeoAppApp.swift
//  mapGeoApp
//
//  Created by Аня Воронцова on 04.12.2023.
//

import SwiftUI

@main
struct mapGeoAppApp: App {
    @StateObject private var vm = MainMapViewModel()
    var body: some Scene {
        WindowGroup {
            MainMapView()
                .environmentObject(vm)
        }
    }
}
