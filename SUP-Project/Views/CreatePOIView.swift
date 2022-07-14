//
//  CreatePOIView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/12/22.
//

import MapKit
import SwiftUI

// MARK: - CreatePOIView

struct CreatePOIView: View {
    @Environment(\.dismiss) var dismiss
    let theme: Theme
    @ObservedObject var model: CreatePOIViewModel

    var body: some View {
        VStack {
            VStack {
                Text("Add Place Of Interest")
                    .font(.title)
                    .foregroundColor(theme.placeListTextColor)
                HStack {
                    Text("POI Name")
                        .foregroundColor(theme.placeListTextColor)
                    TextField("Name", text: $model.name)
                        .textFieldStyle(.roundedBorder)
                }
                POITypePicker(theme: theme, selected: $model.type)
                if model.isFetchingLocation {
                    ProgressView()
                        .foregroundColor(theme.placeListTextColor)
                } else if let error = model.error {
                    Text("ERROR: \(error.localizedDescription)")
                        .foregroundColor(theme.placeListTextColor)
                } else {
                    Map(coordinateRegion: $model.region, annotationItems: model.annotations) { item in
                        MapAnnotation(
                            coordinate: item.location.coordinate,
                            content: {
                                item.type.image
                                    .foregroundColor(theme.poiTextColor)
                            }
                        )
                    }
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                }
                HStack {
                    Button {
                        model.savePoi()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .buttonStyle(CommonButtonStyle.primary)
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    .buttonStyle(CommonButtonStyle.default)

                }.padding(.top, 16)
            }
            .padding()
        }
        .background(PleasantBackgroundView())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Preview

struct CreatePOIView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePOIView(theme: .init(), model: .init(poiService: .init()))
    }
}

// MARK: - CreatePOIViewModel

class CreatePOIViewModel: NSObject, ObservableObject {
    let poiService: POIService
    var locationManager: CLLocationManager?
    @Published var isFetchingLocation = true
    @Published var name: String = "My Spot" {
        didSet {
            updateAnnotations()
        }
    }
    @Published var location: CLLocation? {
        didSet {
            updateAnnotations()
        }
    }
    @Published var type: POIType = .favorite {
        didSet {
            updateAnnotations()
        }
    }
    @Published var error: Error?
    @Published var region: MKCoordinateRegion = .init(center: .init(latitude: 0, longitude: 0), latitudinalMeters: 0, longitudinalMeters: 1000) {
        didSet {
            location = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        }
    }
    @Published var annotations: [POI] = []
    private var poi: POI? {
        guard let location = location else { return nil }
        return POI(name: name, lat: location.coordinate.latitude, lon: location.coordinate.longitude, type: type)
    }

    init(poiService: POIService) {
        self.poiService = poiService
        super.init()
        initializeLocationServices()
    }

    func savePoi() {
        guard let poi = poi else {
            return
        }
        poiService.add(poi: poi)
    }

    private func updateAnnotations() {
        guard let poi = poi else {
            annotations = []
            return
        }
        annotations = [poi]
    }
}

extension CreatePOIViewModel: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        location = lastLocation
        region = MKCoordinateRegion(center: lastLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        isFetchingLocation = false
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.error = error
    }

}

// MARK: - Model implementation

private extension CreatePOIViewModel {

    func initializeLocationServices() {
        guard CLLocationManager.locationServicesEnabled() else {
            #warning("Show user an error message and tell them to enable location services")
            return
        }
        locationManager = CLLocationManager()
        locationManager?.activityType = .other
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
    }

    func checkAuthorization() {
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
            locationManager.requestLocation()
        @unknown default:
            fatalError()
        }
    }
}

extension POI: Identifiable {
    var id: String { "\(name)\(lat)\(lon)\(type.rawValue)" }
}

extension POIType {
    var image: Image {
        guard let systemImageName = systemImageName else {
            return Image(systemName: "xmark.app")
        }
        return Image(systemName: systemImageName)
    }
}
