//
//  CustomerSignUpView.swift
//  Street Food Finder
//
//  Created by Prosperity on 17/4/2026.
//
import SwiftUI

struct CustomerSignUpView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var goToDashBoard = false
    @State private var createdUser: User? = nil
    @State private var password = ""
    @State private var foods: [Food] = [
        Food(name:"Pizza",
             vendor: "Nkosi",
             price: 0.0,
             description:"Cheesy pizza",
             image: "",
             reviews: [],
             latitude: -17.82,
             longitude: 31.05,
             rating: 0.0),
        
        Food (name:"Burger",
        vendor: "Mthethwa",
        price: 0.0,
        description:"Double Burger",
        image: "",
        reviews: [],
        latitude: -17.82,
        longitude: 31.05,
        rating: 0.0),
    ]
    var body: some View {
        
            Form {
                Section(header: Text("Personal Info")) {
                    TextField("Full Name (e.g., Prosperity Ndou)", text: $name)
                        .autocapitalization(.words)
                    TextField("Email (e.g., props@example.com)", text: $email)
                        .autocapitalization(.none)
                    TextField("Phone (e.g., +263775757654)", text: $phone)
                    SecureField("Password (e.g., !Ndou2021!)", text: $password)
                }
                .foregroundColor(.black)
                Button("Sign Up") {
                    createdUser = User(name: name, email: email)
                        goToDashBoard = true
                    print("Customer successfully signed up")
                }
                .disabled(name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty)
                .buttonStyle(.borderedProminent)
                
                
            }.navigationDestination(isPresented: $goToDashBoard) {
                if let user = createdUser {
                    CustomersView(user: user, foods:foods)
                }
            }

            .navigationTitle("Customer Sign Up")
        }
    }

