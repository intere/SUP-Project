//
//  AccountService.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/17/22.
//

import FirebaseCore
import FirebaseAuth
import Foundation


protocol AccountProviding {
    /// Is a user currently signed in?
    var isSignedIn: Bool { get }

    /// Create an account using email and password.
    /// - Parameters:
    ///   - email: The email of the account to create.
    ///   - password: The password of the account to create
    func createAccount(email: String, password: String) async throws

    /// Sign in to an account using an email and password
    /// - Parameters:
    ///   - email: The email of the user.
    ///   - password: The password for the user
    func signIn(email: String, password: String) async throws

    /// Sign out the current user
    func signOut() async throws
}

// MARK: - AccountService

class AccountService {
    static let shared = AccountService()
    let logger: Logging = Logger.shared
    var auth = Auth.auth()
}

// MARK: - AccountService: AccountServicing

extension AccountService: AccountProviding {
    
    var isSignedIn: Bool { auth.currentUser != nil }
    
    func createAccount(email: String, password: String) async throws {
        
        guard !isSignedIn else { throw Error.alreadySignedIn }
        
        let authData = try await auth.createUser(withEmail: email, password: password)
        logger.debug(message: "auth data: \(authData)")
        logger.debug(message: "user: \(authData.user)")
    }
    
    func signIn(email: String, password: String) async throws {
        guard !isSignedIn else { throw Error.alreadySignedIn }
        
        let authData = try await auth.signIn(withEmail: email, password: password)
        
        logger.debug(message: "auth data: \(authData)")
        logger.debug(message: "user: \(authData.user)")
    }
    
    func signOut() async throws {
        guard isSignedIn else { throw Error.notSignedIn }
        
        try auth.signOut()
    }

    enum Error: LocalizedError {
        case alreadySignedIn
        case notSignedIn
        
        var errorDescription: String? {
            switch self {
            case .alreadySignedIn:
                return "You're already signed in"
            case .notSignedIn:
                return "You're not signed in"
            }
        }
    }
}


