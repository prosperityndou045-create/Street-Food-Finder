//
//  SignUpView.swift
//  Street Food Finder
//
//  Created by Prosperity on 25/3/2026.
//

import SwiftUI

struct SignUpView: View {
    @State private var selectedRole: String? = nil
    @State private var goToNext = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("color")
                    .resizable()
                    .frame(width: 400, height: 900)
                   
                
                VStack(spacing: 20) {
                    
                    Text("Choose your role")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                    
                    RoleCard(title: "Customer", icon: "person", isSelected: selectedRole == "Customer") {
                        selectedRole = "Customer"
                    }
                    
                    RoleCard(title: "Vendor", icon: "storefront", isSelected: selectedRole == "Vendor") {
                        selectedRole = "Vendor"
                    }
                    
                    RoleCard(title: "Supplier", icon: "car", isSelected: selectedRole == "Supplier") {
                        selectedRole = "Supplier"
                    }
                    
                    Button("Continue") {
                        goToNext = true
                    }
                    .disabled(selectedRole == nil)
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                    
                   
                    .navigationDestination(isPresented: $goToNext) {
                        switch selectedRole {
                        case "Customer":
                            CustomerSignUpView()
                        case "Vendor":
                            VendorSignUpView()
                        case "Supplier":
                            SupplierSignUpView()
                        default:
                            Text("Select a role")
                        }
                    }
                }
                .padding()
            }
        }
    }
    
  
    struct RoleCard: View {
        let title: String
        let icon: String
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                HStack {
                    Image(systemName: icon)
                    Text(title)
                        .bold()
                        .foregroundColor(isSelected ? .blue : .gray)
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
                )
                .cornerRadius(10)
            }
        }
    }
}


struct CustomerSignUpView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    
    var body: some View {
        
            Form {
                Section(header: Text("Personal Info")) {
                    TextField("Full Name (e.g., Prosperity Ndou)", text: $name)
                    TextField("Email (e.g., props@example.com)", text: $email)
                        .autocapitalization(.none)
                    TextField("Phone (e.g., +263775757654)", text: $phone)
                    SecureField("Password (e.g., !Ndou2021!)", text: $password)
                }
                .foregroundColor(.black)
                Button("Sign Up") {
                    print("Customer successfully signed up")
                }
                .disabled(name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty)
                .buttonStyle(.borderedProminent)
                
                
            }
            .navigationTitle("Customer Sign Up")
        }
    }


struct VendorSignUpView: View {
    @State private var name = ""
    @State private var email = ""
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
                TextField("Location (e.g., Harare, Zimbabwe)", text: $location)
            }
            .foregroundStyle(Color.black)
            
            Button("Sign Up") {
                print("Vendor signed up")
            }
            .disabled(name.isEmpty || email.isEmpty || businessName.isEmpty || location.isEmpty)
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Vendor Sign Up")
    }
}


struct SupplierSignUpView: View {
    @State private var companyName = ""
    @State private var email = ""
    @State private var supplyType = ""
    @State private var deliveryRange = ""
    
    var body: some View {
        Form {
            Section(header: Text("Company Info")) {
                TextField("Company Name (e.g., SupplyCo)", text: $companyName)
                TextField("Email (e.g., supply@example.com)", text: $email)
                    .autocapitalization(.none)
            }
            .foregroundColor(.black)
            
            Section(header: Text("Service Details")) {
                TextField("Supply Type (e.g., Vegetables, Meat)", text: $supplyType)
                TextField("Delivery Range (e.g., 10 km radius)", text: $deliveryRange)
            }
            .foregroundStyle(Color.black)
            Button("Sign Up") {
                print("Supplier signed up")
            }
            .disabled(companyName.isEmpty || email.isEmpty || supplyType.isEmpty || deliveryRange.isEmpty)
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Supplier Sign Up")
    }
}

#Preview {
    SignUpView()
}
