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
        ScrollView {
            VStack(spacing: 15) {

                TextField("Search meals...", text: $searchText)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)

                Map(position: .constant(MapCameraPosition.region(region))) {
                    ForEach(filteredFoods) { food in
                        Annotation(food.name, coordinate: CLLocationCoordinate2D(
                            latitude: food.latitude,
                            longitude: food.longitude
                        )) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
                .frame(height: 250)
                .cornerRadius(12)

                ForEach(filteredFoods) { food in
                    HStack {
                        Image(systemName: "fork.knife")
                        Text(food.name)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Customers")
    }
}


