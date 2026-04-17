//
//  SupplierViewFile.swift
//  Street Food Finder
//
//  Created by Prosperity on 15/4/2026.
//

import SwiftUI
import MapKit


struct SuppliersView: View {
    let foods: [Food]
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -17.8292, longitude: 31.0522),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    )
    
    var body: some View {
        VStack {
            
            Map(position: $position) {
                ForEach(foods) { food in
                    Annotation(food.vendor,
                               coordinate: CLLocationCoordinate2D(
                                latitude: food.latitude,
                                longitude: food.longitude
                               )) {
                                   
                                   Text(food.vendor)
                                       .font(.caption)
                                       .padding(6)
                                       .background(Color.white)
                                       .cornerRadius(6)
                                       .shadow(radius: 2)
                               }
                }
            }
            .frame(height: 300)
            .cornerRadius(12)
            .padding()
            
            Spacer()
        }
        .navigationTitle("Suppliers")
        .navigationBarTitleDisplayMode(.inline)
    }
}
