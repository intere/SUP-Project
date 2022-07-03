//
//  DetailView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import SwiftUI

struct DetailView: View {
    private let location: Place

    var body: some View {
        VStack {
            TitleView(locationName: location.name)
            PlaceImage(place: location, rotation: true)
            ScrollView {
                Text(location.details)
                    .font(.body)
            }
            .padding(.top)
        }
        .padding(.top, -60)
        .padding(.horizontal)
        .background(RoadView())
    }

    init(location: Place) {
        self.location = location
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailView(location: MapContentService().places[0])
        }.padding()
    }
}
