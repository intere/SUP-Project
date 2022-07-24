//
//  PlaceDetailView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import SwiftUI

struct PlaceDetailView: View {
    var theme: Theme
    @State var location: Place

    var body: some View {
        ScrollView {
            VStack {
                TitleView(locationName: location.name)
                    .padding()
                PlaceImage(model: .init(place: location, rotation: true))
                    .padding()
                LazyVGrid(columns: [.init(.flexible(minimum: 100))]) {
                    AllowedView(theme: theme, place: location)
                        .frame(maxWidth: .infinity)
                    DisallowedView(theme: theme, place: location)
                        .frame(maxWidth: .infinity)
                }
                CommonTextView(text: location.details, model: .lightGray)
                NavigationLink(destination: MapDialogView(place: location)) {
                    MapPlaceView(viewModel: .init(allowsUserInteraction: false), place: location)
                        .frame(maxWidth: .infinity, minHeight: 160)
                        .cornerRadius(8)
                        .padding()
                }
            }
        }
        .background(theme.appBackground)
    }
}


struct DetailView_Previews: PreviewProvider {
    static let dependencies = Dependencies()
    static var previews: some View {
        Group {
            PlaceDetailView(theme: .init(), location: dependencies.mapContentProvider.places[1])
        }.padding()
    }
}
