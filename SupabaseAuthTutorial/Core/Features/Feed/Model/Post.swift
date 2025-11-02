//
//  Post.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 11/2/25.
//

import Foundation

struct Post: Identifiable, Codable {
    let id: String
    let caption: String
    let createdAt: Date
    let authorID: String
    let authorUsername: String
    var authorProfileImageUrl: String?
}

