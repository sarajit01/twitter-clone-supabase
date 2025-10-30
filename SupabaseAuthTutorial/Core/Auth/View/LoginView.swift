//
//  LoginView.swift
//  SupabaseAuthTutorial
//
//  Created by Sarajit Barmon on 10/30/25.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(AuthManager.self) private var authManager
    
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                    
                    TextField("Enter your Email", text: $email)
                        .autocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    
                    SecureField("Enter your Password", text: $password)
                        .autocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    
                                            
                }
                
                Button { signIn() } label: {
                    Text("Login")
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
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                }
                .padding(.vertical, 16)
                
                
                
            }
        }
    }
}

private extension LoginView {
    
    func signIn() {
        Task {
            await authManager.signIn(email: email, password: password)
        }
    }
    
    var formIsValid: Bool {
       return email.isValidEmail && !password.isEmpty
    }
    
}

private extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
}

#Preview {
    LoginView().environment(AuthManager())
}
