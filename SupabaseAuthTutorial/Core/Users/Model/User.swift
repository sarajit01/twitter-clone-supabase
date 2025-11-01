//
//  User.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 10/30/25.
//

import Foundation
struct User: Identifiable, Codable {
     
    var id: String
    let email: String
    let username: String
    let createdAt: Date
    var profileImageUrl: String?
    
}
