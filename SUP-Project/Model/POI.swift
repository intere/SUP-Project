//
//  POI.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/10/22.
//

import Foundation
import MapKit

struct POI: Codable {
    let uuid: UUID
    let name: String
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
    let type: POIType

    var location: CLLocation { .init(latitude: lat, longitude: lon) }
}

enum POIType: String, Codable, CaseIterable {
    case parking
    case pushPin
    case mapPin
    case photoSpot
    case favorite
    case boatLaunch

    var systemImageName: String? {
        switch self {
        case .parking:
            return "parkingsign.circle.fill"
        case .pushPin:
            return "pin.circle"
        case .mapPin:
            return "mappin.circle"
        case .photoSpot:
            return "camera.viewfinder"
        case .favorite:
            return "heart.circle"
        case .boatLaunch:
            return "pencil.tip.crop.circle"
        }
    }

    var description: String {
        switch self {
        case .parking:
            return "Parking"
        case .pushPin:
            return "Pushpin"
        case .mapPin:
            return "Pin"
        case .photoSpot:
            return "Photo spot"
        case .favorite:
            return "Favorite spot"
        case .boatLaunch:
            return "Boat launch"
        }
    }
}
