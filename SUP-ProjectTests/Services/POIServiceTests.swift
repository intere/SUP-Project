//
//  POIServiceTests.swift
//  SUP-ProjectTests
//
//  Created by Eric Internicola on 7/12/22.
//

@testable import SUP_Project
import MapKit
import XCTest

class POIServiceTests: XCTestCase {

    var defaults: UserDefaults!
    var subject: POIService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        defaults = UserDefaults(suiteName: "POIServiceTests")
        subject = POIService(defaults: defaults)
    }

    override func tearDownWithError() throws {
        defaults.removeObject(forKey: POIService.Constants.defaultsKey)
        try super.tearDownWithError()
    }

    func testSetAndGet() throws {
        let poi = POI(name: "test", lat: 4, lon: 7, type: .parking)
        subject.placesOfInterest = [poi]
        XCTAssertEqual(1, subject.placesOfInterest.count)

        guard let actual = subject.placesOfInterest.first else { return XCTFail("No POI") }

        XCTAssertEqual(poi.name, actual.name)
        XCTAssertEqual(poi.lat, actual.lat, accuracy: 0.001)
        XCTAssertEqual(poi.lon, actual.lon, accuracy: 0.001)
        XCTAssertEqual(poi.type, actual.type)
    }

    func testEmptyDefaults() throws {
        let pois = subject.placesOfInterest
        XCTAssertEqual(0, pois.count)
    }

    func testNumerousReadsAndWrites() throws {
        (0...100).forEach { value in
            let poi = POI(name: "test", lat: CLLocationDegrees(value), lon: CLLocationDegrees(value), type: .parking)
            subject.add(poi: poi)
            XCTAssertEqual(value + 1, subject.placesOfInterest.count)

            guard let actual = subject.placesOfInterest.last else { return XCTFail("No POI") }

            XCTAssertEqual(poi.name, actual.name)
            XCTAssertEqual(poi.lat, actual.lat, accuracy: 0.001)
            XCTAssertEqual(poi.lon, actual.lon, accuracy: 0.001)
            XCTAssertEqual(poi.type, actual.type)
        }
    }

}
