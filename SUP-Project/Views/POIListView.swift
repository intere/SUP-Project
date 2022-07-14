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
                CreatePOIView(theme: theme, model: .init(poiService: model.poiService))
            }
            .padding()

            LazyVStack {
                ForEach(model.pois) { poi in
                    HStack {
                        poi.type.image
                        Text(poi.name)
                            .padding(.leading, 2)
                    }.foregroundColor(.appTextDark)
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
    @Published var poiService = POIService()
    var pois: [POI] { poiService.placesOfInterest }
    @Published var showingSheet = false
}
