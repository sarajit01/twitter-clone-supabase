//
//  UserManager.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 10/31/25.
//

import Foundation

@Observable
@MainActor
class UserManager {
    
    var currentUser: User?
    
    private let service: UserService
    
    init(service: UserService = UserService()) {
        self.service = service
    }
    
    func fetchCurrentUser() async {
        do {
            self.currentUser = try await service.fetchCurrentUser()
            print("User fetched from supabase")
            print(self.currentUser)
        } catch {
            
            print("Debug error: failed to fetch current user - \(error)")
        }
    }
    
    func updateProfileImgUrl(_ imageUrl: String) async {
        
        do {
            try await service.updateProfileImgUrl(imageUrl)
            self.currentUser?.profileImageUrl = imageUrl
        } catch {
            print("Debug error uploading profile image: \(error.localizedDescription)")
        }
        
    }
    
    
}
