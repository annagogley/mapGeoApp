//
//  SheetView.swift
//  mapGeoApp
//
//  Created by Аня Воронцова on 06.12.2023.
//

import Foundation
import SwiftUI
import CoreLocation
import ConfettiSwiftUI

struct SheetView: View {
    @State var friendTapped : Location
    @State private var checkHistory : Bool = false
    @State private var counter: Int = 0

    var body: some View {
            VStack {
                HStack(alignment: .top, spacing: 12) {
                    ZStack {
                        Circle()
                            .frame(width: 90)
                            .foregroundColor(.blue)
                        Image(friendTapped.imageName)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .cornerRadius(45)
                    }
                    VStack(alignment: .leading) {
                        Text(friendTapped.name)
                            .font(.title2)
                            .bold()
                        HStack {
                            PropertyView(iconName: "wifi", text: "GPS")
                            PropertyView(iconName: "calendar", text: friendTapped.lastSeenDate)
                            PropertyView(iconName: "clock", text: friendTapped.lastSeenTime)
                        }
                    }
                }

                Button {
                    counter += 1
                    checkHistory.toggle()
                } label: {
                    ZStack {
                        Capsule()
                            .frame(width: UIScreen.main.bounds.width - 32, height: 46)
                        Text("Посмотреть историю")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .confettiCannon(counter: $counter) //просто так :)
            }
    }
}

struct PropertyView: View {
    @State var iconName : String
    @State var text : String
    var body: some View {
        HStack(spacing: 4) {
            Image(uiImage: UIImage(systemName: iconName)!)
                .renderingMode(.template)
                .foregroundColor(.blue)
            Text(text)
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(friendTapped: Location(
            name: "Ленка",
            imageName: FriendPhoto.lenka,
            lastSeenDate: "04.12.23",
            lastSeenTime: "15:00",
            location: CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30))
        )
    }
}
