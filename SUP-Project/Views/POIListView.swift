//
//  POIListView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/13/22.
//

import SwiftUI

struct POIListView: View {
    @ObservedObject var model = POIListViewModel()

    var body: some View {
        VStack {
            Button {
                model.showingSheet.toggle()
            } label: {
                Text("Add POI")
            }.sheet(isPresented: $model.showingSheet) {
                CreatePOIView(model: .init())
            }

            LazyVStack {
                ForEach(model.pois) { poi in
                    HStack {
                        poi.type.image
                        Text(poi.name)
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct POIListView_Previews: PreviewProvider {
    static var previews: some View {
        POIListView()
    }
}

class POIListViewModel: ObservableObject {
    let poiService = POIService()
    @Published var pois: [POI]
    @Published var showingSheet = false

    init() {
        pois = poiService.placesOfInterest
    }
}
