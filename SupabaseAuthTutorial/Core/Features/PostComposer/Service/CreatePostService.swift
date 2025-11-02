//
//  CreatePostService.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 11/3/25.
//

import Foundation
import Supabase

struct CreatePostService {
    
    private let client: SupabaseClient
    
    init(){
        self.client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey
        )
    }
    
    
    func createPost(
        caption: String,
        authorID: String,
        authorUsername: String,
        authorProfileImageURL: String?
    ) async throws {
        
        let postId = UUID().uuidString
        let createdAt = Date()
        
        let post = Post(
            id: postId,
            caption: caption,
            createdAt: createdAt,
            authorID: authorID,
            authorUsername: authorUsername,
            authorProfileImageUrl: authorProfileImageURL
        )
        
        try await self.client
            .from(
                "post"
            )
            .insert(
                post
            )
            .execute()
    }
        

    
}
