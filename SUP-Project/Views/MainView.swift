//
//  MainView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/13/22.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        TabView {
            PlacesNavigationView(places: MapContentService().places)
                .tabItem {
                    Label("Spots", systemImage: "list.dash")
                }
            POIListView()
                .tabItem {
                    Label("POIs", systemImage: "square.and.pencil")
                }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
