//
//  Place.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/2/22.
//

import Foundation
import MapKit

enum Watercraft: String, Codable {
    case paddleboard = "p"
    case kayak = "k"
    case canoe = "c"
    case sailing = "s"

    var title: String {
        switch self {
        case .paddleboard:
            return "Paddleboards"
        case .kayak:
            return "Kayaks"
        case .canoe:
            return "Canoes"
        case .sailing:
            return "Sailboats"
        }
    }
}

enum WaterBodyType: String, Codable {
    case lake = "l"
    case pond = "p"
    case river = "r"
    case whitewater = "w"
    case reservoir = "e"
}

class Place: Codable {
    let name: String
    let image: String
    let details: String
    let location: CLLocation
    var region: MKCoordinateRegion
    let type: WaterBodyType?
    let motorized: Bool?
    let allowed: [Watercraft]?
    let prohibited: [Watercraft]?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKey.self)
        name = try values.decode(String.self, forKey: .name)
        image = try values.decode(String.self, forKey: .image)
        details = try values.decode(String.self, forKey: .details)
        let latitude = try values.decode(Double.self, forKey: .latitude)
        let longitude = try values.decode(Double.self, forKey: .longitude)
        location = CLLocation(latitude: latitude, longitude: longitude)
        region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: Constants.regionRadius,
                                    longitudinalMeters: Constants.regionRadius)
        type = try? values.decode(WaterBodyType.self, forKey: .type)
        motorized = try? values.decode(Bool.self, forKey: .motorized)
        allowed = try? values.decode([Watercraft].self, forKey: .allowed)
        prohibited = try? values.decode([Watercraft].self, forKey: .prohibited)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKey.self)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
        try container.encode(details, forKey: .details)
        try container.encode(location.coordinate.latitude, forKey: .latitude)
        try container.encode(location.coordinate.longitude, forKey: .longitude)
        if let type = type {
            try container.encode(type, forKey: .type)
        }
        if let motorized = motorized {
            try container.encode(motorized, forKey: .motorized)
        }
        if let allowed = allowed {
            try container.encode(allowed, forKey: .allowed)
        }
        if let prohibited = prohibited {
            try container.encode(prohibited, forKey: .prohibited)
        }
    }

    enum CodingKey: Swift.CodingKey {
        case name
        case image
        case sponsored
        case details
        case overlay
        case latitude
        case longitude
        case type
        case motorized
        case allowed
        case prohibited
    }

    struct Constants {
        static let regionRadius: CLLocationDistance = 1000
    }
}

extension Place: Identifiable {
    var id: String { self.name }
}

// MARK: - Computed Properties

extension Place {
    var allowedWatercraft: [Watercraft] {
        allowed ?? []
    }

    var prohibitedWatercraft: [Watercraft] {
        prohibited ?? []
    }
}
