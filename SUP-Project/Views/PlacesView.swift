//
//  PlacesView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import SwiftUI

struct PlacesView: View {
    let places: [Place]
    @Binding var selectedPlace: Place

    var body: some View {
        VStack {
            NavigationLink(destination: DetailView(location: selectedPlace)) {
                LocationPhoto(photoName: selectedPlace.image)
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
                NavigationLink(destination: MapView(location: place)) {
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

extension PlacesView {
    struct OtherPlacesScrollView: View {
        @Binding var selectedPlace: Place
        let places: [Place]

        var body: some View {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(places.indices, id: \.self) { index in
                        let place = places[index]
                        Image(place.image)
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            .aspectRatio(1, contentMode: .fill)
                            .onTapGesture {
                                selectedPlace = place
                            }
                    }
                }
                .padding(.leading)
            }

        }
    }
}


struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        //        PlacesView(places: MapContentService().places, selectedPlace: MapContentService().places[0])
        EmptyView()
    }
}
