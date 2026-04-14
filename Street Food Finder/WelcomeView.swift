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
                Image("color")
                    .resizable()
                    .opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Welcome ")
                        .font(.system(size: 50, design: .serif))
                        .foregroundColor(Color.dark )
                        .bold()
                        .padding(10)
                        .opacity(0.7)
                        .offset(x: 0, y: -140)
                    
                    Text("To")
                        .font(.system(size: 40, design:.serif))
                        .bold()
                        .foregroundColor(Color.dark)
                        .opacity(0.7)
                        .offset(x: 0, y: -130)
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .cornerRadius(160)
                        .opacity(0.8)
                        .offset(x: 0, y: -60)
                    
                }
                
               VStack {
                   Spacer()
                    
                   NavigationLink(destination: SignInView()) {
                       Text("Continue")
                           .font(.system(size: 20, design: .serif))
                           .foregroundStyle(Color.white)
                           .padding(10)
                           .background(Color.red)
                           .opacity(0.8)
                           .cornerRadius(10)
                       
                       
                   }
                }
                
            }
            
        }
        
    }
    
}
        
        
    


#Preview {
    WelcomeView()
}
