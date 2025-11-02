//
//  UserProfileView.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 10/31/25.
//

import SwiftUI
import PhotosUI

struct UserProfileView: View {
    
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImg: Image?
    @State private var showPhotosPicker: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                
                // Header
                Section {
                    HStack(spacing: 16) {
                        Group {
                            
                            if let profileImg {
                                profileImg
                                    .resizable()
                                     .clipShape(Circle())
                                
                                  
                            }
                            
                            else if let profileImgUrl = userManager.currentUser?.profileImageUrl {
                                
                                AsyncImage(url: URL(string: profileImgUrl)!) { image in
                                    image.resizable()
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }
                            } else {
                                //                                AsyncImage(url: URL(string: "https://picsum.photos/200" )!) { image in
                                //                                    image.resizable()
                                //                                        .clipShape(Circle())
                                //                                } placeholder: {
                                //                                    ProgressView()
                                //                                }
                                
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .foregroundStyle(.tertiary)
                            }
                        }
                        .frame(width: 72, height: 72)
                        .onTapGesture {
                            showPhotosPicker.toggle()
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(userManager.currentUser?.username ?? "Loading ...")
                            Text(userManager.currentUser?.email ?? "Loading ...")
                                .foregroundStyle(.secondary)
                        }
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
            .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItem)
        }
        .task {
             await userManager.fetchCurrentUser()
        }
        .task(id: selectedItem) {
            await onImageSelected()
        }
    }
}


private extension UserProfileView {
    
    func onImageSelected() async {
        
        guard let selectedItem, let user = userManager.currentUser else {return}
        
        do {
            guard let data = try await selectedItem.loadTransferable(type: Data.self) else { return }
            guard let uiImage = UIImage(data: data) else { return }
                    
            self.profileImg = Image(uiImage: uiImage)
            
            let userProfileImgUrl = try await SupabaseStorageManager().uploadProfilePhoto(for: user, imageData: data)
            if (userProfileImgUrl == nil) {
                print("Failed uploading profile image from view");
            } else {
                userManager.currentUser?.profileImageUrl = userProfileImgUrl
                await userManager.updateProfileImgUrl(userProfileImgUrl!)
                
            }
            
        } catch {
            print("Debug error: failed to select image with error \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    UserProfileView()
        .environment(AuthManager())
        .environment(UserManager())
}
