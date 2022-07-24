//
//  MainView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/13/22.
//

import SwiftUI

struct MainViewModel {
    let dependencies: Dependencies
    var theme: Theme { dependencies.theme }
    var places: [Place] { dependencies.mapContentProvider.places }
}

struct MainView: View {
    let model: MainViewModel

    var body: some View {
        TabView {
            PlacesNavigationView(places: model.places)
                .tabItem {
                    Label("Spots", image: "PlaceList")
                }
            POIListView(model: .init(dependencies: model.dependencies))
                .tabItem {
                    Label("POIs", image: "POIList")
                }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(model: .init(dependencies: .init()))
    }
}
