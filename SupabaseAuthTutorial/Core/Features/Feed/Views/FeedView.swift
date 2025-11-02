//
//  FeedView.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 11/2/25.
//

import SwiftUI

struct FeedView: View {
    
    @State private var showPostComposer = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack {
                        
                        ForEach(0..<10) { post in
                            FeedCell()
                        }
                        
                    }
                }
                
                Button { showPostComposer.toggle() } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                    
                }.padding()
              
            }
            .fullScreenCover(isPresented: $showPostComposer, content: {
                
                PostComposerView()
                
            })
            .navigationTitle("Feed")
        }
    }
}

#Preview {
    FeedView()
}
