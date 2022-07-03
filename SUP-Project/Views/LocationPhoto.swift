//
//  LocationPhoto.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import SwiftUI

struct LocationPhoto: View {
    let photoName: String

    var body: some View {
        AsyncImage(url: URL(string: photoName)!) { phase in
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
                    .rotationEffect(.degrees(.random(in: -5 ... 5)), anchor: .center)
            } else if let error = phase.error {
                Text("ERROR with image: \(error.localizedDescription)")
            } else {
                ProgressView()
            }
        }

//        Image(photoName)

    }
}

struct LocationPhoto_Previews: PreviewProvider {
    static var previews: some View {
        LocationPhoto(photoName: "holenrock")
    }
}
