//
//  VendorViewFile.swift
//  Street Food Finder
//
//  Created by Prosperity on 15/4/2026.
//

import SwiftUI
import MapKit

struct VendorsView: View {
    let vendors: [Vendor]

    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -17.8292, longitude: 31.0522),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    )

    @State private var selectedVendor: Vendor? = nil

    var body: some View {
        VStack {
            Map(position: $position) {
                ForEach(vendors) { vendor in
                    Annotation(vendor.name, coordinate: vendor.coordinate) {
                        Image(systemName: "building.2.fill")
                            .font(.title)
                            .foregroundColor(.brown)
                            .padding(6)
                            .background(Color.white)
                            .clipShape(Circle())
                            .onTapGesture {
                                selectedVendor = vendor
                            }
                    }
                }
            }
            .frame(height: 400)
            .cornerRadius(12)
            .padding()

            if let vendor = selectedVendor {
                VStack(alignment: .leading) {
                    Text(vendor.name).font(.headline)
                    Text(vendor.businessName)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }

            Spacer()
        }
        .navigationTitle("Vendors")
    }
}



