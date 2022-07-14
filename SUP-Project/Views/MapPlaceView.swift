//
//  MapPlaceView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/5/22.
//

import MapKit
import SwiftUI

struct MapPlaceView: View {
    @StateObject var viewModel: ContentViewModel
    @State var place: Place

    var body: some View {
        Map(coordinateRegion: $place.region, interactionModes: viewModel.interactionModes, showsUserLocation: true, annotationItems: [place]) {
            MapAnnotation(
                coordinate: $0.location.coordinate,
                content: {
                    Image(systemName: "drop.circle.fill")
                        .foregroundColor(.red)
                        .onTapGesture(count: 1) {
                            print("You tapped me")
                        }
                }
            )
        }
        .onAppear {
            viewModel.initializeLocationServices()
        }
    }
}


struct MapPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        MapPlaceView(viewModel: .init(), place: MapContentService().places[0])
    }
}

extension MapPlaceView {
    class ContentViewModel: NSObject, ObservableObject {
        var locationManager: CLLocationManager?
        var allowsUserInteraction: Bool

        var interactionModes: MapInteractionModes {
            allowsUserInteraction ? [.all] : []
        }

        init(allowsUserInteraction: Bool = true) {
            self.allowsUserInteraction = allowsUserInteraction
        }

        func initializeLocationServices() {
            guard CLLocationManager.locationServicesEnabled() else {
                #warning("Show user an error message and tell them to enable location services")
                return
            }
            locationManager = CLLocationManager()
            locationManager?.activityType = .otherNavigation
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.delegate = self
        }

        private func checkAuthorization() {
            guard let locationManager = locationManager else {
                return
            }
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
#warning("TODO: likely parental control restriction")
            case .denied:
#warning("TODO: you denied me permissions")
            case .authorizedAlways, .authorizedWhenInUse:
                break
            @unknown default:
                fatalError()
            }
        }
    }
}

extension MapPlaceView.ContentViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
}
