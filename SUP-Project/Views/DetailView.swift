//
//  DetailView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import SwiftUI

struct DetailView: View {
    @State var location: Place

    var body: some View {
        ScrollView {
            VStack {
                TitleView(locationName: location.name)
                    .padding()
                PlaceImage(model: .init(place: location, rotation: true))
                    .padding()
                LazyVGrid(columns: [.init(.flexible(minimum: 100))]) {
                    AllowedView(place: location)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray))
                    DisallowedView(place: location)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray))
                }
                Text(location.details)
                    .font(.body)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).fill(.white.opacity((0.3))))
                    .padding()
                NavigationLink(destination: MapDialogView(place: location)) {
                    MapPlaceView(viewModel: .init(allowsUserInteraction: false), place: location)
                        .frame(maxWidth: .infinity, minHeight: 160)
                        .cornerRadius(8)
                        .padding()
                }
            }
        }
        .background(PleasantBackgroundView())
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
