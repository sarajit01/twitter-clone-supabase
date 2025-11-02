//
//  ContentView.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 10/30/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AuthManager.self) private var authManager
    
    var body: some View {
        Group {
            if authManager.currentUserID != nil {
                MainTabBar()
            } else {
                LoginView()
            }
        }
        .task {
            await authManager.refreshUser()
        }
    }
}

#Preview {
    ContentView().environment(AuthManager())
}
