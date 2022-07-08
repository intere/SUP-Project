//
//  MapChooser.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/7/22.
//

import MapKit
import SwiftUI

struct MapPoint: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

class MapChooserModel: ObservableObject {
    @Published var region: MKCoordinateRegion

    var annotations: [MapPoint] {
        [MapPoint(coordinate: region.center)]
    }

    init(with location: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: location, span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
    }

}

struct MapChooser: View {
    @StateObject var viewModel: MapChooserModel

    var body: some View {
        Map(coordinateRegion: $viewModel.region, interactionModes: [.all], showsUserLocation: true, annotationItems: viewModel.annotations) {
            MapMarker(coordinate: $0.coordinate, tint: .blue)
        }
    }
}

struct MapChooser_Previews: PreviewProvider {
    static var previews: some View {
        MapChooser(viewModel: .init(with: CLLocationCoordinate2D(latitude: 39.610617852590536, longitude: -106.06083437485576)))
    }
}
