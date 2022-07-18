//
//  AccountService.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/17/22.
//

import FirebaseCore
import FirebaseAuth
import Foundation


protocol AccountServicing {
    var isSignedIn: Bool { get }
    
    func createAccount(email: String, password: String) async throws
    func signIn(email: String, password: String) async throws
    
    func signOut() async throws
}

// MARK: - AccountService

class AccountService {
    static let shared = AccountService()
    var auth = Auth.auth()
}

// MARK: - AccountService: AccountServicing

extension AccountService: AccountServicing {
    
    var isSignedIn: Bool { auth.currentUser != nil }
    
    func createAccount(email: String, password: String) async throws {
        
        guard !isSignedIn else { throw Error.alreadySignedIn }
        
        let authData = try await auth.createUser(withEmail: email, password: password)
        print("auth data: \(authData)")
        print("user: \(authData.user)")
    }
    
    func signIn(email: String, password: String) async throws {
        guard !isSignedIn else { throw Error.alreadySignedIn }
        
        let authData = try await auth.signIn(withEmail: email, password: password)
        
        print("auth data: \(authData)")
        print("user: \(authData.user)")
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


