//
//  PlaceTests.swift
//  SUP-ProjectTests
//
//  Created by Eric Internicola on 7/3/22.
//

@testable import SUP_Project
import XCTest

class PlaceTests: XCTestCase {
    var placesJsonUrl: URL? {
        Bundle.main.url(forResource: "places", withExtension: "json")
    }

    func testJsonResourceExists() throws {
        XCTAssertNotNil(placesJsonUrl)
    }

    func testPlacesCanParse() throws {
        guard let placesJsonUrl = placesJsonUrl else {
            return XCTFail("Failed to get Places JSON URL")
        }
        let data = try Data(contentsOf: placesJsonUrl)
        let decoder = JSONDecoder()
        let places = try decoder.decode([Place].self, from: data)

        XCTAssertTrue(places.count > 0)
    }
}
