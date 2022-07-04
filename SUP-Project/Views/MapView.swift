//
//  ContentView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/2/22.
//

import MapKit
import SwiftUI

struct MapView: View {
    @State var place: Place
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ZStack {
            Map(coordinateRegion: $place.region, annotationItems: [place]) {
                MapPin(coordinate: $0.location.coordinate)
            }.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(place: MapContentService().places[0])
    }
}

extension Place: Identifiable {
    var id: String { self.name }
}
