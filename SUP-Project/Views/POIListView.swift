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

            List {
                ForEach(model.pois) { poi in
                    HStack {
                        poi.type.image
                            .renderingMode(.template)
                            .foregroundColor(theme.poiListColor)
                        Text(poi.name)
                            .foregroundColor(theme.poiListColor)
                            .padding(.leading, 2)
                    }
                    .padding(.bottom, 4)
                    .swipeActions {
                        Button {
                            model.remove(poi)
                        } label: {
                            Text("Delete")
                        }
                        .buttonStyle(CommonButtonStyle.danger)
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
    @Published var poiService = POIService()
    @Published var showingSheet = false
    var pois: [POI] { poiService.placesOfInterest }

    func remove(_ poi: POI) {
        poiService.remove(poi: poi)
        objectWillChange.send()
    }
}
