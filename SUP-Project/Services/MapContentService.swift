//
//  MapContentService.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import Foundation

class MapContentService {
    private let placesJsonUrl = Bundle.main.url(forResource: "places", withExtension: "json")

    lazy var places: [Place] = {
        guard let placesJsonUrl = placesJsonUrl else {
            fatalError("Failed to find places.json")
        }
        do {
            let jsonData = try Data(contentsOf: placesJsonUrl)
            return try JSONDecoder().decode([Place].self, from: jsonData)
        } catch {
            fatalError(error.localizedDescription)
        }
    }()
}
