//
//  OtherPlacesScrollView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import SwiftUI

struct OtherPlacesScrollView: View {
    @Binding var selectedPlace: Place
    let places: [Place]

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(places.indices, id: \.self) { index in
                    VStack {
                        Text(places[index].name)
                            .font(.title2)
                        PlaceImage(place: places[index], rotation: false)
                    }.onTapGesture {
                        selectedPlace = places[index]
                    }.padding()
                }
            }
            .padding(.leading)

        }
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray))
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct OtherPlacesScrollView_Previews: PreviewProvider {
    static var model = PreviewModel()
    static var previews: some View {
        Group {
            OtherPlacesScrollView(selectedPlace: model.$selectedPlace, places: model.places).preferredColorScheme(.dark)
            OtherPlacesScrollView(selectedPlace: model.$selectedPlace, places: model.places).preferredColorScheme(.light)
        }
    }

    struct PreviewModel {
        var places = MapContentService().places
        @State var selectedPlace: Place

        init() {
            selectedPlace = places[0]
        }
    }
}
