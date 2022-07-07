//
//  ContentView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import SwiftUI

struct ContentView: View {
    let places: [Place]
    @State private var selectedPlace: Place

    init(places: [Place]) {
        self.places = places
        _selectedPlace = .init(initialValue: places.first!)
    }

    var body: some View {
        NavigationView {
//            PlacesView(places: places, selectedPlace: $selectedPlace)
            PlacesList(places: places, selectedPlace: $selectedPlace)
                .background(PleasantBackgroundView())
                .navigationBarHidden(true)

            Text("\(Image(systemName: "arrow.left")) Choose a SUP Place!")
                .font(.largeTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(places: MapContentService().places)
    }
}
