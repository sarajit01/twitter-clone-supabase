//
//  SupabaseStorageManager.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 11/1/25.
//

import Supabase
import Foundation

struct SupabaseStorageManager {
    
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey
        )
    }
    
    func uploadProfilePhoto(for user: User, imageData: Data) async throws -> String? {
        
        do {
            let path = "\(user.id)/avatar.jpg" ;
            

            if (user.profileImageUrl == nil) {
                print("Profile image not present. Uploading new one.")
                try await client.storage.from("avatars")
                    .upload(path,data: imageData)
            } else {
                
                print("Profile image already present. Updating existing one.")
                try await client.storage.from("avatars")
                    .update(path,data: imageData, options: FileOptions(upsert: true))
            }
            
            let publicUrl = try client.storage.from("avatars").getPublicURL(path: path)
            print("Debug Profile photo uploaded. Public URL: \(publicUrl.absoluteString)")
            
            
            return publicUrl.absoluteString
        } catch {
            print("Debug error uploading photo to storage: \(error.localizedDescription)")
            return nil
            
        }
    }
    
}

