//
//  MainView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/13/22.
//

import SwiftUI

struct MainView: View {
    let theme: Theme

    var body: some View {
        TabView {
            PlacesNavigationView(places: MapContentService().places)
                .tabItem {
                    Label("Spots", image: "PlaceList")
                }
            POIListView(theme: theme)
                .tabItem {
                    Label("POIs", image: "POIList")
                }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(theme: .init())
    }
}
