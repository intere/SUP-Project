//
//  AddPlaceView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/7/22.
//

import MapKit
import SwiftUI

struct AddPlaceModel {
    var name: String = ""
    var latitude: CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0
    var type: WaterBodyType = .lake
    var image: String = ""
    var details: String = ""
    var allowed: [Watercraft] = []
    var prohibited: [Watercraft] = []
}

struct AddPlaceView: View {
    @State var place = AddPlaceModel()

    var body: some View {
        ScrollView {
            HStack {
                Text("Name")
                TextField("name", text: $place.name)
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                Text("Latitude")
                
            }
        }.padding()
    }
}

struct AddPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaceView()
    }
}

