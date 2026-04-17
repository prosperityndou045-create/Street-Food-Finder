//
//  SignUpView.swift
//  Street Food Finder
//
//  Created by Prosperity on 14/4/2026.
//


import SwiftUI

struct SignUpView: View {
    @State private var selectedRole: String? = nil
    @State private var goToNext = false

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

                VStack(spacing: 20) {

                    Text("Choose your role")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)

                    RoleCard(title: "Customer", icon: "person",
                             isSelected: selectedRole == "Customer") {
                        selectedRole = "Customer"
                    }

                    RoleCard(title: "Vendor", icon: "storefront",
                             isSelected: selectedRole == "Vendor") {
                        selectedRole = "Vendor"
                    }

                    RoleCard(title: "Supplier", icon: "car",
                             isSelected: selectedRole == "Supplier") {
                        selectedRole = "Supplier"
                    }

                    Button("Continue") {
                        goToNext = true
                    }
                    .disabled(selectedRole == nil)
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .padding(.top)
                }
                .padding()
            }
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
                    .foregroundColor(isSelected ? .blue : .brown)

                Text(title)
                    .bold()
                    .foregroundColor(isSelected ? .blue : .brown)

                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                isSelected
                ? Color.brown.opacity(0.25)
                : Color.white.opacity(0.6)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.brown : Color.clear, lineWidth: 2)
            )
            .cornerRadius(10)
        }
    }
}

struct User {
    var name: String
    var email: String
}

struct Supplier {
    var companyName: String
    var supplyType: String
}

struct Product: Identifiable {
    let id = UUID()
    var name: String
    var price: Double
}


struct SupplierProfileManagement: View {
    var supplier: Supplier

    @State private var businessName = ""
    @State private var contactPerson = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var location = ""
    @State private var businessType = ""

    @State private var products: [Product] = [
        Product(name: "Fresh Tomatoes", price: 5.0),
        Product(name: "Cabbage", price: 12.5)
    ]

    @State private var goToSuppliersView = false
    @State private var isSaved = false

    var body: some View {
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

            ScrollView {
                VStack(spacing: 20) {

                    Text("Supplier Profile")
                        .font(.title)
                        .bold()

                    Group {
                        TextField("Business Name", text: $businessName)
                        TextField("Contact Person", text: $contactPerson)
                        TextField("Email", text: $email)
                        TextField("Phone", text: $phone)
                        TextField("Location", text: $location)
                        TextField("Business Type", text: $businessType)
                    }
                    .textFieldStyle(.roundedBorder)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Products")
                            .font(.headline)

                        ForEach(products) { product in
                            HStack {
                                Text(product.name)
                                Spacer()
                                Text("$\(product.price, specifier: "%.2f")")
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                        }

                        Button("Add Product") {
                            products.append(Product(name: "New Product", price: 0.0))
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }

                    Button("Save Profile") {
                        isSaved = true
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)

                    Button("Go to SuppliersView") {
                        goToSuppliersView = true
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)

                    if isSaved {
                        Text("Profile Saved")
                            .foregroundColor(.green)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Supplier Profile")

        .navigationDestination(isPresented: $goToSuppliersView) {
            SuppliersView(
                foods: [
                    Food(
                        name: "Burger",
                        vendor: "Foodies Hub",
                        price: 5.99,
                        description: "Juicy burger",
                        image: "burger",
                        reviews: [],
                        latitude: -17.8292,
                        longitude: 31.0522,
                        rating: 4.5
                    )
                ]
            )
        }
    }
}
    #Preview {
            SignUpView()
        }
    
