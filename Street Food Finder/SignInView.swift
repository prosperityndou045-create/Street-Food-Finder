//
//  SignInView.swift
//  Street Food Finder
//
//  Created by Prosperity on 25/3/2026.
//

import SwiftUI

import SwiftUI

struct SignInView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var showAlert = false  // <-- state for alert

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.brown)
                    .opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack(spacing: 40) {
                Image(systemName: "person.2.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.red)
                
                Text("Login")
                    .font(.system(size: 28, weight: .bold))
                
                Text("Welcome back, login to continue!")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            .padding(.top, 40)
            
            VStack(alignment: .leading, spacing: 25) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Username")
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    TextField("", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.caption)
                        .foregroundColor(.black)
                    SecureField("", text: $password)
                    Divider()
                }
            }
            .padding(.top, 60)
            .padding(.horizontal, 30)
            
            HStack {
                Toggle(isOn: $rememberMe) {
                    Text("Remember me")
                        .font(.footnote)
                        .foregroundColor(.black)
                }
                .toggleStyle(.button)
                .tint(.purple.opacity(0.4))
                
                Spacer()
            }
            .padding(.leading, 30)
            
            Spacer()
            
            VStack(spacing: 20) {
                Button(action: {
                    // This triggers the alert
                    showAlert = true
                }) {
                    Text("Login to my Account")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .alert("Success", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("You have successfully logged in!")
                }
                
                NavigationLink(destination: SignUpView()) {
                    Text("Signup for New Account")
                        .font(.footnote)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 60)
        }
    }
}

#Preview {
    SignInView()
}

