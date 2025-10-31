//
//  User.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 10/30/25.
//

import Foundation
struct User: Identifiable, Codable {
     
    let id: String
    let email: String
    let username: String
    let createdAt: Date
    let profileImageUrl: String? = nil
    
}
