//
//  PostComposerView.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 11/2/25.
//

import SwiftUI

struct PostComposerView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var caption: String = ""
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                HStack(alignment: .top,spacing: 8) {
                    
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .scaledToFill()
                        .clipShape(Circle())
                    
                    TextField("What's in your mind?", text: $caption, axis: .vertical)
                    
                }
                
                Spacer()
                
                
            }.padding()
            
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Post")
                    }
                    .disabled(caption.isEmpty)
                    .opacity(caption.isEmpty ? 0.5 : 1.0)
                }
                
                
            }

            
        }
        
    }
}

#Preview {
    PostComposerView()
}
