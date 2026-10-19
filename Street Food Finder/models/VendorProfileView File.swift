//
//  VendorProfileView File.swift
//  Street Food Finder
//
//  Created by Prosperity on 17/4/2026.
//

import SwiftUI
import PhotosUI

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

    @State private var goToVendorView = false

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

                ScrollView {
                    VStack(spacing: 20) {

                        
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
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
                            TextField("Category (e.g., Fast Food, Bakery)", text: $category)
                            TextField("Operating Hours", text: $operatingHours)

                            TextEditor(text: $about)
                                .frame(height: 100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5))
                                )
                        }
                        .textFieldStyle(.roundedBorder)

                        Group {
                            TextField("Phone", text: $phone)
                            TextField("Email", text: $email)
                            TextField("Location", text: $location)
                        }
                        .textFieldStyle(.roundedBorder)

                        
                        Button(action: saveVendorProfile) {
                            Text("Save Profile")
                                .foregroundColor(.white)
                                .frame(maxWidth: 200)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(10)
                        }

                        
                        Button("Vendor View") {
                            goToVendorView = true
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: 200)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)

                    }
                    .padding()
                }
            }
            .navigationTitle("Vendor Profile")

      
            .navigationDestination(isPresented: $goToVendorView) {
                VendorsView(
                    vendors: [
                        Vendor(
                            name: "Test",
                            businessName: "Test Business",
                            latitude: 0.0,
                            longitude: 0.0
                        )
                    ]
                )
            }
        }
    }

    func saveVendorProfile() {
        print("Vendor Profile Saved!")
    }
}
