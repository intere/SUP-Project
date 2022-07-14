//
//  POIService.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/12/22.
//

import Foundation

class POIService {
    let defaults: UserDefaults

    var placesOfInterest: [POI] {
        get {
            let data = defaults.object(forKey: Constants.defaultsKey) as? Data
            return pois(from: data)
        }
        set {
            let data = data(from: newValue)
            defaults.set(data, forKey: Constants.defaultsKey)
        }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func add(poi: POI) {
        placesOfInterest.append(poi)
    }

    struct Constants {
        static let defaultsKey = "my.places.of.interest"
        static let encoder = JSONEncoder()
        static let decoder = JSONDecoder()
    }
}

// MARK: - Implementation

private extension POIService {
    func data(from pois: [POI]) -> Data? {
        do {
            return try Constants.encoder.encode(pois)
        } catch {
#warning("TODO: log error")
            return nil
        }
    }

    func pois(from data: Data?) -> [POI] {
        guard let data = data else { return [] }
        do {
            return try Constants.decoder.decode([POI].self, from: data)
        } catch {
            #warning("TODO: log error")
            return []
        }
    }
}
