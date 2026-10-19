//
//  CustomerView FIle.swift
//  Street Food Finder
//
//  Created by Prosperity on 15/4/2026.
//

import SwiftUI
import MapKit

struct CustomersView: View {
    @State var user: User
    @State var foods: [Food]

    @State private var searchText = ""
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -17.8292, longitude: 31.0522),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var filteredFoods: [Food] {
        searchText.isEmpty ? foods :
        foods.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    var body: some View {
        ZStack {

            LinearGradient(
                colors: [
                    Color.brown.opacity(0.25),
                    Color.white.opacity(0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 15) {

                    TextField("Search meals...", text: $searchText)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.brown.opacity(0.3))
                        )

                    Map(position: .constant(MapCameraPosition.region(region))) {
                        ForEach(filteredFoods) { food in
                            Annotation(food.name, coordinate: CLLocationCoordinate2D(
                                latitude: food.latitude,
                                longitude: food.longitude
                            )) {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.brown)
                            }
                        }
                    }
                    .frame(height: 250)
                    .cornerRadius(12)

                    ForEach(filteredFoods) { food in
                        HStack {

                            Image(food.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .clipped()
                                .cornerRadius(8)
                          
                            Text(food.name)
                                .foregroundColor(.black)

                            Spacer()

                            Image(systemName: "chevron.right")
                                .foregroundColor(.black.opacity(0.6))
                        }
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.brown.opacity(0.2))
                        )
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Customers")
    }
}
                  
