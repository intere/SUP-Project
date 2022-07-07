//
//  PlaceImage.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import SwiftUI

struct PlaceImageModel {
    let place: Place
    let rotation: Bool
    let maxWidth: CGFloat?
    let maxHeight: CGFloat?
    let emptyViewForMissing: Bool
    let borderWidth: CGFloat
    let borderColor: Color

    init(
        place: Place,
        rotation: Bool = false,
        maxWidth: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        emptyViewForMissing: Bool = false,
        borderWidth: CGFloat = 0,
        borderColor: Color = .black
    ) {
        self.place = place
        self.rotation = rotation
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.emptyViewForMissing = emptyViewForMissing
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }

    static func noBorder(_ place: Place) -> PlaceImageModel {
        .init(place: place, borderWidth: 0)
    }
}

struct PlaceImage: View {
    let model: PlaceImageModel

    var angle: Angle {
        guard model.rotation else { return Angle(degrees: 0) }
        return .degrees(.random(in: -5 ... 5))
    }

    var body: some View {
        if model.place.image.isEmpty {
            if model.emptyViewForMissing {
                EmptyView()
            } else {
                Image(systemName: "x.square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: model.maxWidth, maxHeight: model.maxHeight)
                    .padding(4)
                    .background(Color.white)
                    .border(model.borderColor, width: model.borderWidth)
                    .shadow(radius: 30)
                    .padding(.top)
                    .rotationEffect(angle, anchor: .center)
                    .foregroundColor(.black)
            }
        } else {
            AsyncImage(url: URL(string: model.place.image)!) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: model.maxWidth, maxHeight: model.maxHeight)
                        .padding(4)
                        .background(Color.white)
                        .border(model.borderColor, width: model.borderWidth)
                        .shadow(radius: 30)
                        .padding(.top)
                        .rotationEffect(angle, anchor: .center)
                } else if let error = phase.error {
                    Text("ERROR with image: \(error.localizedDescription)")
                } else {
                    ProgressView()
                }
            }
        }
    }
}

struct PlaceImage_Previews: PreviewProvider {
    static var previews: some View {
        PlaceImage(model: .init(place: MapContentService().places[0], rotation: true))
    }
}
