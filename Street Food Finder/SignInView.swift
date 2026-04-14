//
//  SignInView.swift
//  Street Food Finder
//
//  Created by Prosperity on 25/3/2026.
//


import SwiftUI

struct SignInView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var goToSignUp = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.brown)
                    .opacity(0.2)
                    .ignoresSafeArea()

                VStack(spacing: 25) {

                    VStack(spacing: 15) {
                        Image(systemName: "person.2.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.red)

                        Text("Login")
                            .font(.system(size: 28, weight: .bold))
                            .padding(10)
                        
                        Text("Welcome back, login to continue!")
                            .font(.subheadline)
                            .padding(10)
                    }

                    VStack(alignment: .leading, spacing: 20) {

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Username")
                                .font(.caption)

                            TextField("Enter username", text: $username)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(10)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Password")
                                .font(.caption)

                            SecureField("Enter password", text: $password)
                                .textFieldStyle(.roundedBorder)
                        }
                    }

                    Toggle("Remember me", isOn: $rememberMe)
                        .font(.footnote)

                    Button(action: {
                        if !username.isEmpty && !password.isEmpty {
                            goToSignUp = true
                        }
                    }) {
                        Text("Login to my Account")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(20)
              
                    NavigationLink(destination: SignUpView()) {
                        Text("Signup for New Account")
                            .font(.footnote)
                    }

                    Spacer()
                }
                .padding()
            }
        
            .navigationDestination(isPresented: $goToSignUp) {
                SignUpView()
            }
        }
    }
}

#Preview {
    SignInView()
    
}
