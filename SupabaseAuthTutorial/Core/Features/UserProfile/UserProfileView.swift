//
//  UserProfileView.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 10/31/25.
//

import SwiftUI

struct UserProfileView: View {
    
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    var body: some View {
        NavigationStack {
            List {
                
                // Header
                Section {
                    if let currentUser = userManager.currentUser {
                        Text(currentUser.username)
                    }
                }
                
                // Sign out
                Section {
                    Button("Sign Out") {
                        Task {
                            await authManager.signOut()
                        }
                    }
                    .foregroundStyle(.red)
                    
                }
            }
            .navigationTitle("Profile")
        }
        .task {
             await userManager.fetchCurrentUser()
        }
    }
}

#Preview {
    UserProfileView()
}
