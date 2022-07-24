//
//  POIListView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/13/22.
//

import SwiftUI

struct POIListView: View {
    @ObservedObject var model: POIListViewModel
    var theme: Theme { model.dependencies.theme }

    var body: some View {
        VStack {
            Button {
                model.showingSheet.toggle()
            } label: {
                Text("Add POI")
            }
            .buttonStyle(CommonButtonStyle.primary)
            .sheet(isPresented: $model.showingSheet) {
                CreatePOIView(model: .init(dependencies: model.dependencies))
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
        .background(theme.appBackground)
        .padding()
    }
}

struct POIListView_Previews: PreviewProvider {
    static var previews: some View {
        POIListView(model: .init(dependencies: .init()))
    }
}

class POIListViewModel: ObservableObject {
    let dependencies: Dependencies
    @Published var poiProvider: POIProviding
    @Published var showingSheet = false
    var pois: [POI] { poiProvider.placesOfInterest }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.poiProvider = dependencies.poiProvider
    }

    func remove(_ poi: POI) {
        poiProvider.remove(poi: poi)
        objectWillChange.send()
    }
}
