//
//  VendorSignUpView.swift
//  Street Food Finder
//
//  Created by Prosperity on 17/4/2026.
//

import SwiftUI

struct VendorSignUpView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var vendor: Vendor? = nil
    @State private var goToDashboard = false
    @State private var businessName = ""
    @State private var location = ""
    
    var body: some View {
        Form {
            Section(header: Text("Account")) {
                TextField("Full Name (e.g., Progress Ndou)", text: $name)
                TextField("Email (e.g., vendor@example.com)", text: $email)
                    .autocapitalization(.none)
            }
            .foregroundStyle(Color.black)
            
            Section(header: Text("Business Info")) {
                TextField("Business Name (e.g., Real Bakery)", text: $businessName)
                TextField("Location (e.g., Victoria Falls, Zimbabwe)", text: $location)
            }
            .foregroundStyle(Color.black)
            
            Button("Sign Up") {
                print("Vendor signed up")
                vendor = Vendor(name: name, businessName: businessName, latitude: 0.0, longitude: 0.0)
                    goToDashboard = true
            }
            .disabled(name.isEmpty || email.isEmpty || businessName.isEmpty || location.isEmpty)
            .buttonStyle(.borderedProminent)
        }
        .navigationDestination(isPresented: $goToDashboard) {
            if let vendor = vendor {
                VendorProfileView(vendor: vendor)
            }
        }
        .navigationTitle("Vendor Sign Up")
    }
}
