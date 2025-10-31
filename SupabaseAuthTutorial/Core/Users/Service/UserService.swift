//
//  UserService.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 10/31/25.
//

import Supabase
import Foundation


struct UserService {
    
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey
        )
            
    }
    
    func fetchCurrentUser() async throws -> User {
        let user = try await client.auth.session.user ;
        
        print("Fetch current user: \(user.id.uuidString)")
        
        return try await client.from("users")
            .select()
            .eq("id", value: user.id.uuidString)
            .single()
            .execute()
            .value
        
        
    }
    
}
