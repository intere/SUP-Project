//
//  MapContentService.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import Foundation

protocol MapContentProviding {
    var places: [Place] { get }
}

class MapContentService: MapContentProviding {
    private let logger: Logging
    private let placesJsonUrl = Bundle.main.url(forResource: "places", withExtension: "json")

    lazy var places: [Place] = {
        guard let placesJsonUrl = placesJsonUrl else {
            logger.fatal(message: "Failed to find places.json")
            return []
        }
        do {
            let jsonData = try Data(contentsOf: placesJsonUrl)
            return try JSONDecoder().decode([Place].self, from: jsonData)
        } catch {
            logger.fatal(error: error)
            return []
        }
    }()

    init(logger: Logging = Logger.shared) {
        self.logger = logger
    }
}
