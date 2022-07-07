//
//  ContentView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/2/22.
//

import MapKit
import SwiftUI

struct MapDialogView: View {
    @State var place: Place
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ZStack {
            MapPlaceView(place: place).edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .renderingMode(.template)
                            .foregroundColor(.black.opacity(0.75))
                            .imageScale(.large)
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapDialogView(place: MapContentService().places[0])
    }
}
