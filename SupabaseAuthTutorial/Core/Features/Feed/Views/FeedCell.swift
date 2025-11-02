//
//  FeedCell.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 11/2/25.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 56, height: 56)
                    .scaledToFill()
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4){
                    
                    HStack {
                        Text("Sarajit").font(.headline)
                        
                        Text("• " + "1 day ago")
                    }
                    
                    Text("This is a test post for now ...")
                    
                }
                Spacer()
                
            }
            .padding()
            .background(Color(.systemBackground))
            
            Divider()
            
        }
        
    }
}

#Preview {
    FeedCell()
}
