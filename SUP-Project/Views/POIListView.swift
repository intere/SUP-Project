//
//  POIListView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/13/22.
//

import SwiftUI

struct POIListView: View {
    let theme: Theme
    @ObservedObject var model = POIListViewModel()

    var body: some View {
        VStack {
            Button {
                model.showingSheet.toggle()
            } label: {
                Text("Add POI")
            }
            .buttonStyle(CommonButtonStyle.primary)
            .sheet(isPresented: $model.showingSheet) {
                CreatePOIView(theme: theme, model: .init())
            }
            .padding()

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
        .background(PleasantBackgroundView())
        .padding()
    }
}

struct POIListView_Previews: PreviewProvider {
    static var previews: some View {
        POIListView(theme: .init())
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
