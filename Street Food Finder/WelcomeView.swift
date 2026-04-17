//
//  WelcomeView.swift
//  Street Food Finder
//
//  Created by Prosperity on 25/3/2026.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {

                LinearGradient(
                    colors: [
                        Color.brown.opacity(0.35),
                        Color.white.opacity(0.9)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {

                    Text("Welcome")
                        .font(.system(size: 50, design: .serif))
                        .foregroundColor(.dark)
                        .bold()
                        .padding(10)
                        .opacity(0.8)
                        .offset(y: -140)

                    Text("To")
                        .font(.system(size: 40, design: .serif))
                        .bold()
                        .foregroundColor(.dark.opacity(0.8))
                        .offset(y: -130)

                    Image("logo")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.brown.opacity(0.4), lineWidth: 4)
                        )
                        .opacity(0.9)
                        .offset(y: -60)
                }

                VStack {
                    Spacer()

                    NavigationLink(destination: SignInView()) {
                        Text("Continue")
                            .font(.system(size: 20, design: .serif))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 160)
                            .background(Color.red)
                            .cornerRadius(12)
                            .shadow(color: .brown.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }
}
#Preview {
    WelcomeView()
}
