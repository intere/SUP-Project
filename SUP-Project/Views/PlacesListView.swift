//
//  PlacesList.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/6/22.
//

import SwiftUI


class PlacesListViewModel: ObservableObject {
    @Published var searchText: String
    var places: [Place]
    @Published var selectedPlace: Place
    @Published var showPlace: Int?
    
    var filtered: [Place] {
        guard !searchText.isEmpty else { return places }
        return places.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    init(searchText: String = "", places: [Place], selectedPlace: Place? = nil) {
        self.searchText = searchText
        self.places = places
        if let selectedPlace = selectedPlace {
            self.selectedPlace = selectedPlace
        } else if let firstPlace = places.first {
            self.selectedPlace = firstPlace
        } else {
            fatalError()
        }
    }
}

struct PlacesListView: View {
    var theme: Theme
    @StateObject var model: PlacesListViewModel

    var body: some View {
        NavigationLink(destination: PlaceDetailView(theme: theme, location: model.selectedPlace), tag: 1, selection: $model.showPlace) {
            EmptyView()
        }
        ScrollView {
            LazyVStack {
                ForEach(model.filtered) { place in
                    HStack(alignment: .center) {
                        Text(place.name)
                            .font(.title2)
                            .foregroundColor(theme.placeListTextColor)
                        Spacer()
                        PlaceImage(model: .init(place: place, rotation: false, maxHeight: 40, emptyViewForMissing: true))
                    }
                    .padding([.leading, .trailing], 20)
                    .padding([.top, .bottom], 4)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .onTapGesture {
                        print("You tapped \(place.name)")
                        model.selectedPlace = place
                        model.showPlace = 1
                    }
                    Spacer()
                }
            }
        }
    }
}

struct PlacesList_Previews: PreviewProvider {
    static var model = PreviewModel()
    static var theme = Theme()

    static var previews: some View {
        Group {
            PlacesListView(theme: .init(), model: model.viewModel).preferredColorScheme(.dark)
            PlacesListView(theme: .init(), model: model.viewModel).preferredColorScheme(.light)
        }
    }

    struct PreviewModel {
        @State var viewModel: PlacesListViewModel
        var places: [Place]
        @State var selectedPlace: Place

        init(places: [Place] = MapContentService().places) {
            self.places = places
            self.selectedPlace = places[0]
            self.viewModel = PlacesListViewModel(searchText: "", places: model.places, selectedPlace: model.selectedPlace)
        }
    }
}
