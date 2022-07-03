//
//  MapContentServiceTests.swift
//  SUP-ProjectTests
//
//  Created by Eric Internicola on 7/3/22.
//

@testable import SUP_Project
import XCTest

class MapContentServiceTests: XCTestCase {

    let subject = MapContentService()

    func testLoadPlaces() throws {
        XCTAssertNotNil(subject.places)
    }
}
