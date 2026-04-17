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
                            .foregroundColor(.white)
                            .background(Color.brown)
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
        .background(
            LinearGradient(
                colors: [
                    Color.brown.opacity(0.35),
                    Color.white.opacity(0.9)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .navigationTitle("Suppliers")
        .navigationBarTitleDisplayMode(.inline)
    }
}
