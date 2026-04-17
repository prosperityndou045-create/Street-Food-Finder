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

                LinearGradient(
                    colors: [
                        Color.brown.opacity(0.30),
                        Color.white.opacity(0.95)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
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
                            .foregroundColor(.black.opacity(0.9))

                        Text("Welcome back, login to continue!")
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(0.8))
                    }
                    .padding(20)

                    VStack(alignment: .leading, spacing: 20) {

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Username")
                                .font(.callout)
                                .foregroundColor(.black)

                            TextField("Enter username", text: $username)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(18)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(10)

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Password")
                                .font(.callout)
                                .foregroundColor(.black)

                            SecureField("Enter password", text: $password)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(18)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(10)
                    }

                    Toggle("Remember me", isOn: $rememberMe)
                        .font(.footnote)
                        .tint(.blue)

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
                            .shadow(color: .brown.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                    .padding(.horizontal, 20)

                    NavigationLink(destination: SignUpView()) {
                        Text("Signup for New Account")
                            .font(.footnote)
                            .foregroundColor(.blue)
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
