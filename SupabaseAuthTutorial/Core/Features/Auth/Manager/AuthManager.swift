//
//  AuthManager.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 10/30/25.
//

import Foundation
import Observation

@Observable
@MainActor
class AuthManager {
    
    private let authService: SupabaseAuthService
    var currentUserID: String?
    
    init(authService: SupabaseAuthService = SupabaseAuthService()) {
        self.authService = authService
    }
    
    func signUp(email: String, password: String, username: String) async {
        do {
            self.currentUserID = try await authService.signUp(email: email, password: password, username: username)
        } catch {
            print("Debug error signing up: \(error.localizedDescription)")
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            self.currentUserID = try await authService.signIn(email: email, password: password)
        } catch {
            print("Debug error signing in: \(error.localizedDescription)")
        }
    }
    
    func signOut() async {
        do {
            try await authService.signOut()
            currentUserID = nil
        } catch {
            print("Debug error signing out: \(error.localizedDescription)")
        }
    }
    
    func refreshUser() async {
        do {
            self.currentUserID = try await authService.getCurrentUser()
        } catch {
            print("Debug error refreshing user: \(error.localizedDescription)")
            self.currentUserID = nil
        }
    }
    
}
