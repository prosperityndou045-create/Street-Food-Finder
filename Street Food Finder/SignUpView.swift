//
//  SignUpView.swift
//  Street Food Finder
//
//  Created by Prosperity on 25/3/2026.
//

import SwiftUI
import PhotosUI

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

    struct User {
        var name: String
        var email: String
    }


struct CustomerSignUpView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var goToDashboard = false
    @State private var createdUser: User? = nil
    @State private var password = ""
    
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
                        goToDashboard = true
                    print("Customer successfully signed up")
                }
                .disabled(name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty)
                .buttonStyle(.borderedProminent)
                
                
            }.navigationDestination(isPresented: $goToDashboard) {
                if let user = createdUser {
                    CustomerDashboardView(user: user)
                }
            }
            .navigationTitle("Customer Sign Up")
        }
    }
struct CustomerDashboardView: View {
    let user: User

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome, \(user.name) 👋")
                .font(.largeTitle)
                .bold()

            Text("Email: \(user.email)")
        }
    }
}
struct Vendor {
    var name: String
    var businessName: String
}

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
                vendor = Vendor(name: name, businessName: businessName)
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
struct VendorProfileView: View {
    var vendor: Vendor
    @State private var vendorName = ""
    @State private var about = ""
    @State private var category = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var location = ""
    @State private var operatingHours = ""
    
    @State private var profileImage: Image? = nil
    @State private var selectedItem: PhotosPickerItem? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            if let profileImage = profileImage {
                                profileImage
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 120, height: 120)
                                    .overlay(Text("Add Logo"))
                            }
                        }
                        .task(id: selectedItem) {
                            guard let newItem = selectedItem else { return }
                            if let data = try? await newItem.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                profileImage = Image(uiImage: uiImage)
                            }
                        }

                    Group {
                        TextField("Vendor Name", text: $vendorName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Category (e.g., Fast Food, Bakery)", text: $category)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Operating Hours", text: $operatingHours)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextEditor(text: $about)
                            .frame(height: 100)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                            .padding(.horizontal)
                    }

               
                    Group {
                        TextField("Phone", text: $phone)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Location", text: $location)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

        
                    Button(action: saveVendorProfile) {
                        Text("Save Profile")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
                .padding()
            }
            .navigationTitle("Vendor Profile")
        }
    }

    func saveVendorProfile() {
        print("Vendor Profile Saved!")
    }
}

struct VendorProfileView_Previews: PreviewProvider {
    static var previews: some View {
        VendorProfileView(vendor: Vendor.init(name: "Test", businessName: "Test Business)"))
    }
}
struct SupplierProfileManagement: View {
            var supplier: Supplier
            @State private var businessName = "Vegetables Supplies"
            @State private var contactPerson = "Proe Ndou"
            @State private var email = "supplier@example.com"
            @State private var phone = "+263 77 123 4567"
            @State private var location = "Victoria Falls, Zimbabwe"
            @State private var businessType = "Wholesaler"
            
           
            @State private var products: [Product] = [
                Product(name: "Fresh Tomatoes", price: 5.0),
                Product(name: "Cabbage", price: 12.5)
            ]
            
            var body: some View {
                NavigationStack {
                    ScrollView {
                        VStack(spacing: 20) {
                         
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Supplier Profile")
                                    .font(.title)
                                    .bold()
                                
                                Group {
                                    TextField("Business Name", text: $businessName)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                                    TextField("Contact Person", text: $contactPerson)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                                    TextField("Email", text: $email)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.emailAddress)
                                    
                                    TextField("Phone", text: $phone)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.phonePad)
                                    
                                    TextField("Location", text: $location)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                                    TextField("Business Type", text: $businessType)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            
                         
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Products")
                                    .font(.headline)
                                
                                ForEach(products) { product in
                                    HStack {
                                        Text(product.name)
                                        Spacer()
                                        Text("$\(String(format: "%.2f", product.price))")
                                    }
                                    .padding()
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                                }
                                
                                Button(action: addProduct) {
                                    Text("Add Product")
                                        .fontWeight(.bold)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                            .padding()
                            
                            Spacer()
                        }
                        .padding()
                    }
                    .navigationTitle("Supplier Dashboard")
                }
            }
            
          
            func addProduct() {
                
                let newProduct = Product(name: "New Product", price: 0.0)
                products.append(newProduct)
            }
        }


        struct Product: Identifiable {
            let id = UUID()
            var name: String
            var price: Double
        }

struct SupplierProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SupplierProfileManagement(
            supplier: Supplier(companyName: "Test Co", supplyType: "Vegetables")
        )
    }
}

#Preview {
    SupplierProfileManagement(
        supplier: Supplier(companyName: "Test Co", supplyType: "Vegetables")
    )
}

struct Supplier {
    var companyName: String
    var supplyType: String
}
struct SupplierSignUpView: View {
    @State private var companyName = ""
    @State private var email = ""
    @State private var supplier: Supplier? = nil
    @State private var goToDashboard = false
    @State private var supplyType = ""
 
    
@State private var deliveryRange = ""
    var body: some View {
        NavigationStack {
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
                    supplier = Supplier(companyName: companyName, supplyType: supplyType)
                        goToDashboard = true
                    print("Supplier signed up")
                }
                .disabled(companyName.isEmpty || email.isEmpty || supplyType.isEmpty || deliveryRange.isEmpty)
                .buttonStyle(.borderedProminent)
            }
            .navigationDestination(isPresented: $goToDashboard) {
                if let supplier = supplier{
                    SupplierProfileManagement(supplier: supplier)
                }
            }

            .navigationTitle("Supplier Sign Up")
        }
        
    }
    
}

#Preview {
    SignUpView()
}

