//
//  Place.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/2/22.
//

import Foundation
import MapKit

final class Place: Codable {
    let name: String
    let image: String
    let sponsored: Bool
    let details: String
    let overlay: Bool
    let location: CLLocation
    var region: MKCoordinateRegion
    private let regionRadius: CLLocationDistance = 1000

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKey.self)
        name = try values.decode(String.self, forKey: .name)
        image = try values.decode(String.self, forKey: .image)
        sponsored = try values.decode(Bool.self, forKey: .sponsored)
        details = try values.decode(String.self, forKey: .details)
        overlay = try values.decode(Bool.self, forKey: .overlay)
        let latitude = try values.decode(Double.self, forKey: .latitude)
        let longitude = try values.decode(Double.self, forKey: .longitude)
        location = CLLocation(latitude: latitude, longitude: longitude)
        region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKey.self)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
        try container.encode(sponsored, forKey: .sponsored)
        try container.encode(details, forKey: .details)
        try container.encode(overlay, forKey: .overlay)
        try container.encode(location.coordinate.latitude, forKey: .latitude)
        try container.encode(location.coordinate.longitude, forKey: .longitude)
    }

    enum CodingKey: Swift.CodingKey {
        case name
        case image
        case sponsored
        case details
        case overlay
        case latitude
        case longitude
    }
}


