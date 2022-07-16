//
//  PlacesDatabaesTest.swift
//  SUP-ProjectTests
//
//  Created by Eric Internicola on 7/16/22.
//

@testable import SUP_Project
import XCTest

class PlacesDatabaesTest: XCTestCase {

    let subject = PlacesDatabase.shared

    func testHasDatabase() {
        XCTAssertNotNil(subject.database)
    }

}
