//
//  POIService.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/12/22.
//

import Combine
import Foundation

protocol POIProviding {
    var placesOfInterest: [POI] { get }
    func add(poi: POI)
    func remove(poi: POI)
}

class POIService: ObservableObject {
    let defaults: UserDefaults
    let logger: Logging

    init(defaults: UserDefaults = .standard, logger: Logging = Logger.shared) {
        self.logger = logger
        self.defaults = defaults
    }

    struct Constants {
        static let defaultsKey = "my.places.of.interest"
        static let encoder = JSONEncoder()
        static let decoder = JSONDecoder()
    }
}

// MARK: - POIProviding

extension POIService: POIProviding {

    var placesOfInterest: [POI] {
        get {
            let data = defaults.object(forKey: Constants.defaultsKey) as? Data
            return pois(from: data)
        }
        set {
            let data = data(from: newValue)
            defaults.set(data, forKey: Constants.defaultsKey)
            objectWillChange.send()
        }
    }

    func add(poi: POI) {
        placesOfInterest.append(poi)
        objectWillChange.send()
    }

    func remove(poi: POI) {
        guard let index = placesOfInterest.firstIndex(where: { $0.uuid == poi.uuid }) else { return }
        placesOfInterest.remove(at: index)
        objectWillChange.send()
    }
}

// MARK: - Implementation

private extension POIService {
    func data(from pois: [POI]) -> Data? {
        do {
            return try Constants.encoder.encode(pois)
        } catch {
            logger.error(error: error)
            return nil
        }
    }

    func pois(from data: Data?) -> [POI] {
        guard let data = data else { return [] }
        do {
            return try Constants.decoder.decode([POI].self, from: data)
        } catch {
            logger.error(error: error)
            return []
        }
    }
}
