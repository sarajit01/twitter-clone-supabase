//
//  RegistrationView.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 10/30/25.
//

import SwiftUI

struct RegistrationView: View {
    
    @Environment(AuthManager.self) private var authManager
    
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmedPassword: String = ""
    @State private var passwordsMatch = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                Image("supabase")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                
                VStack(spacing: 8) {
                    
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    
                    TextField("Enter your username", text: $username)
                        .autocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    
                    
                    ZStack(alignment: .trailing) {
                        
                        SecureField("Enter your password", text: $password)
                            .autocapitalization(.none)
                            .font(.subheadline)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        if !password.isEmpty && !confirmedPassword.isEmpty {
                            
                            Image(systemName: passwordsMatch ? "checkmark.circle.fill" :
                            
                                    "xmark.circle.fill"
                            
                            ).foregroundStyle(passwordsMatch ? .green : .red)
                                .padding(.horizontal)
                            
                        }
                    }
                    .padding(.horizontal, 24)

                                    
                    ZStack(alignment: .trailing) {
                        
                        SecureField("Confirm your password", text: $confirmedPassword)
                            .autocapitalization(.none)
                            .font(.subheadline)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    
                        if !password.isEmpty && !confirmedPassword.isEmpty {
                            
                            
                            Image(systemName: passwordsMatch ? "checkmark.circle.fill" :
                            
                                    "xmark.circle.fill"
                            
                            ).foregroundStyle(passwordsMatch ? .green : .red)
                                .padding(.horizontal)
                            
                        }
                        
                    }
                    
                    .padding(.horizontal, 24)

                    
                    .onChange(of: confirmedPassword){ oldValue, newValue in
                        passwordsMatch = newValue == password
                    }
                }

                
                Button { signUp() } label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 44)
                        .background(Color(.systemBlue))
                        .cornerRadius(8)
                    
                }
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1 : 0.5)
                .padding(.vertical)
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        Text("Sign In")
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                }
                .padding(.vertical, 16)
                
                
                
            }
        }
    }
    
    
    
}

private extension RegistrationView {
    
    func signUp() {
        Task {
            await authManager.signUp(email: email, password: password, username: username)
        }
    }
    
    var formIsValid: Bool {
        return email.isValidEmail && passwordsMatch
    }
    
}

private extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
}


#Preview {
    RegistrationView().environment(AuthManager())
}
