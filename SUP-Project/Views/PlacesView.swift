//
//  PlacesView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import SwiftUI

@available(*, deprecated, message: "Use PlaceList instead")
struct PlacesView: View {
    let places: [Place]
    @Binding var selectedPlace: Place

    var body: some View {
        VStack {
            NavigationLink(destination: DetailView(location: selectedPlace)) {
                PlaceImage(model: .init(place: selectedPlace, rotation: true))
            }
            .padding(.horizontal)

            TitleView(locationName: selectedPlace.name)
                .padding([.top, .horizontal])
            Spacer()
            VStack(spacing: 16) {
                Text("Address Goes Here")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                LocationOptionsView(place: selectedPlace, places: places)
            }
            Spacer()
            OtherPlacesScrollView(selectedPlace: $selectedPlace, places: places)
                .padding(.vertical)
        }
    }
}

extension PlacesView {
    struct LocationOptionsView: View {
        let place: Place
        let places: [Place]

        var body: some View {
            VStack(spacing: 10) {
                NavigationLink(destination: MapDialogView(place: place)) {
                    Label(
                        title: { Text("Find on Map")
                                .foregroundColor(.white)
                            .fontWeight(.bold) },
                        icon: {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.black)
                        }
                    )
                }
                Button {
                    print("Directions goes here")
                } label: {
                    Label(
                        title: { Text("Get Directions")
                                .foregroundColor(.white)
                            .fontWeight(.bold) },
                        icon: {
                            Image(systemName: "map.fill")
                                .foregroundColor(.black)
                        }
                    )
                }
            }
        }
    }
}

struct PlacesView_Previews: PreviewProvider {

    static var model = PreviewModel()

    static var previews: some View {
        Group {
            PlacesView(places: model.places, selectedPlace: model.$selectedPlace).preferredColorScheme(.light)
            PlacesView(places: model.places, selectedPlace: model.$selectedPlace).preferredColorScheme(.dark)
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
