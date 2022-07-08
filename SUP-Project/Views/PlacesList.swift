//
//  PlacesList.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/6/22.
//

import SwiftUI

struct PlacesList: View {
    var theme: Theme
    @State var places: [Place]
    @Binding var selectedPlace: Place
    @State private var showPlace: Int?

    var body: some View {
        ScrollView {
            LazyVStack {
                NavigationLink(destination: DetailView(theme: theme, location: selectedPlace), tag: 1, selection: $showPlace) {
                    EmptyView()
                }
                ForEach(places) { place in
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
                        selectedPlace = place
                        showPlace = 1
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
            PlacesList(theme: .init(), places: model.places, selectedPlace: model.$selectedPlace).preferredColorScheme(.dark)
            PlacesList(theme: .init(), places: model.places, selectedPlace: model.$selectedPlace).preferredColorScheme(.light)
        }
    }

    struct PreviewModel {
        var places: [Place]
        @State var selectedPlace: Place

        init(places: [Place] = MapContentService().places) {
            self.places = places
            self.selectedPlace = places[0]
        }
    }
}
