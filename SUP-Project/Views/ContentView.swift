//
//  ContentView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import SwiftUI

struct ContentView: View {
    let theme = Theme()
    let places: [Place]
    @State private var selectedPlace: Place

    init(places: [Place]) {
        self.places = places
        _selectedPlace = .init(initialValue: places.first!)
    }

    var body: some View {
        NavigationView {
            PlacesList(theme: theme, places: places, selectedPlace: $selectedPlace)
                .background(PleasantBackgroundView().overlay(theme.contentOverlay))
                .navigationBarHidden(true)

            Text("\(Image(systemName: "arrow.left")) Choose a SUP Place!")
                .font(.largeTitle)
        }.accentColor(theme.navigationTextColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(places: MapContentService().places).preferredColorScheme(.light)
        ContentView(places: MapContentService().places).preferredColorScheme(.dark)
    }
}
