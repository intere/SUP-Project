//
//  AccountServiceTests.swift
//  SUP-ProjectTests
//
//  Created by Eric Internicola on 7/17/22.
//

@testable import SUP_Project
import XCTest

class AccountServiceTests: XCTestCase {
    
    let subject = AccountService.shared
    
    override func setUp() async throws {
        try await super.setUp()
        
        if subject.isSignedIn {
            try await subject.signOut()
        }
    }
    
    // Verified and it works...
    func testCreateAccount() async throws {
        let email = "intere+test@gmail.com"
        let password = "Test1234$"
        
        try await subject.createAccount(email: email, password: password)
    }
    
    func testIsNotSignedIn() async throws {
        XCTAssertFalse(subject.isSignedIn)
    }
    
    func testSignIn() async throws {
        let email = "intere+test@gmail.com"
        let password = "Test1234$"
        
        try await subject.signIn(email: email, password: password)
        XCTAssertTrue(subject.isSignedIn)
    }

}
