//
//  PlacesNavigationView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import SwiftUI

struct PlacesNavigationView: View {
    let theme = Theme()
    let places: [Place]
    @State private var selectedPlace: Place

    init(places: [Place]) {
        self.places = places
        _selectedPlace = .init(initialValue: places.first!)
    }

    var body: some View {
        NavigationView {
            PlacesListView(theme: theme, model: PlacesListViewModel(places: places, selectedPlace: selectedPlace))
                .background(theme.appBackground
                        .overlay(theme.contentOverlay)
                )
                .navigationBarHidden(true)
            Text("\(Image(systemName: "arrow.left")) Choose a SUP Place!")
                .font(.largeTitle)
        }.accentColor(theme.navigationTextColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let dependencies = Dependencies()
    static var previews: some View {
        PlacesNavigationView(places: dependencies.mapContentProvider.places).preferredColorScheme(.light)
        PlacesNavigationView(places: dependencies.mapContentProvider.places).preferredColorScheme(.dark)
    }
}
