//
//  MainTabBar.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 11/3/25.
//

import SwiftUI

struct MainTabBar: View {
    var body: some View {
        TabView {
            
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Feed")
            }
            
            
            UserProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
            }
            
            
        }
    }
}

#Preview {
    MainTabBar()
}
