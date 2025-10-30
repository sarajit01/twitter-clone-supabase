//
//  SupabaseAuthService.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 10/30/25.
//

import Supabase
import Foundation

struct SupabaseAuthService {
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey
        )
            
    }
    
    func signUp(email: String, password: String) async throws -> User {
        let response = try await client.auth.signUp(email: email, password: password)
        print(response.user);
        
        guard let email = response.user.email else {
            print("No email");
            throw NSError() ;
        }
        
        return User(id: response.user.aud , email: email);
    }
    
    func signIn(email: String, password: String) async throws -> User {
        let response = try await client.auth.signIn(email: email, password: password)
        print(response.user);
        
        guard let email = response.user.email else {
            print("No email")
            throw NSError();
        }
        
        return User(id: response.user.aud, email: email)
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func getCurrentUser() async throws -> User? {
        let supabaseUser = try await client.auth.session.user;
        
        guard let email = supabaseUser.email else {
            print("Debug error getting current user: No email found")
            throw NSError()
        }
        
        return User(id: supabaseUser.aud, email: email)
        
    }
}
