//
//  PlaceImage.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import SwiftUI

struct PlaceImage: View {
    let place: Place
    let rotation: Bool

    var angle: Angle {
        guard rotation else { return Angle(degrees: 0) }
        return .degrees(.random(in: -5 ... 5))
    }

    var body: some View {
        AsyncImage(url: URL(string: place.image)!) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200)
                    .padding(10)
                    .background(Color.white)
                    .border(Color.black, width: 2)
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

struct PlaceImage_Previews: PreviewProvider {
    static var previews: some View {
        PlaceImage(place: MapContentService().places[0], rotation: true)
    }
}
