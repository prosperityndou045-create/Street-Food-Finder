//
//  SupplierSignUpView File.swift
//  Street Food Finder
//
//  Created by Prosperity on 17/4/2026.
//

import SwiftUI

struct SupplierSignUpView: View {
    @State private var companyName = ""
    @State private var email = ""
    @State private var supplyType = ""
    @State private var deliveryRange = ""

    @State private var goToDashboard = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Company Info")) {
                    TextField("Company Name", text: $companyName)
                    TextField("Email", text: $email)
                }

                Section(header: Text("Service Details")) {
                    TextField("Supply Type", text: $supplyType)
                    TextField("Delivery Range", text: $deliveryRange)
                }

                Button("Sign Up") {
                    goToDashboard = true
                }
                .buttonStyle(.borderedProminent)
                .disabled(companyName.isEmpty ||
                          email.isEmpty ||
                          supplyType.isEmpty ||
                          deliveryRange.isEmpty)
            }
            .navigationTitle("Supplier Sign Up")
            .navigationDestination(isPresented: $goToDashboard) {
                SupplierProfileManagement(
                    supplier: Supplier(
                        companyName: companyName,
                        supplyType: supplyType
                    )
                )
            }
        }
    }
}
