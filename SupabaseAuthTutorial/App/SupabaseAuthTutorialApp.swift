//
//  SupabaseAuthTutorialApp.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 10/30/25.
//
import SwiftUI

@main
struct SupabaseAuthTutorialApp: App {
    
    
    @State private var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authManager)
        }
    }
}
