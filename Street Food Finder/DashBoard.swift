//
//  DashBoard.swift
//  Street Food Finder
//
//  Created by Prosperity on 13/4/2026.
//

import SwiftUI
import MapKit


struct DashBoard: View {
    @State private var searchText = ""

    @State private var foods: [Food] = [
        Food(name: "Burger", vendor: "Foodies Hub", price: 5.99, description: "Juicy burger", image: "fork.knife", reviews: [], latitude: -17.8292, longitude: 31.0522, rating: 4.5),
        Food(name: "Pizza", vendor: "Pizza Palace", price: 8.49, description: "Cheesy pizza", image: "fork.knife", reviews: [], latitude: -17.8310, longitude: 31.0450, rating: 4.8),
        Food(name: "Chicken", vendor: "Grill House", price: 6.75, description: "Grilled chicken", image: "fork.knife", reviews: [], latitude: -17.8350, longitude: 31.0600, rating: 4.2)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.brown.opacity(0.15).ignoresSafeArea()

                VStack(alignment: .leading, spacing: 20) {

                    header
                    searchBar

                    VStack(spacing: 15) {

                        NavigationLink(destination: CustomersView(foods: foods)) {
                            sectionHeader(title: "Customers", color: .orange)
                        }

                        NavigationLink(destination: SuppliersView(foods: foods)) {
                            sectionHeader(title: "Suppliers", color: .blue)
                        }

                        NavigationLink(
                            destination: VendorsView(
                                vendors: foods.map {
                                    Vendor(
                                        name: $0.vendor,
                                        businessName: $0.vendor,
                                        latitude: $0.latitude,
                                        longitude: $0.longitude
                                    )
                                }
                            )
                        ) {
                            sectionHeader(title: "Vendors", color: .brown)
                        }
                    }

                    Text("🔥 Featured Foods")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)

                  
                    FoodHighlightBanner(foods: foods)
                        .padding(.horizontal)

                    Spacer()
                }
            }
        }
    }


    var header: some View {
        HStack {
            Text("Dashboard")
                .font(.largeTitle).bold()

            Spacer()

            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.brown)
            }
        }
        .padding()
    }

 
    var searchBar: some View {
        TextField("Search...", text: $searchText)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
    }


    func sectionHeader(title: String, color: Color) -> some View {
        HStack {
            Text(title).bold()
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(color)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct FoodHighlightBanner: View {
    let foods: [Food]

    @State private var offset: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            let itemWidth: CGFloat = 160
            let totalWidth = CGFloat(foods.count) * itemWidth

            HStack(spacing: 20) {
                ForEach(foods) { food in
                    VStack(spacing: 8) {
                        Image(systemName: food.image)
                            .font(.largeTitle)
                            .foregroundColor(.brown)

                        Text(food.name)
                            .font(.headline)

                        Text("$\(food.price, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(width: itemWidth, height: 120)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 3)
                }
            }
            .offset(x: offset)
            .onAppear {
                offset = geo.size.width

                withAnimation(.linear(duration: 12).repeatForever(autoreverses: false)) {
                    offset = -totalWidth
                }
            }
        }
        .frame(height: 140)
        .clipped()
    }
}


struct CustomersView: View {
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


struct SuppliersView: View {
    let foods: [Food]

    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -17.8292, longitude: 31.0522),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    )

    var body: some View {
        Map(position: $position) {
            ForEach(foods) { food in
                Annotation(food.vendor, coordinate: CLLocationCoordinate2D(
                    latitude: food.latitude,
                    longitude: food.longitude
                )) {
                    Text(food.vendor)
                        .padding(5)
                        .background(Color.white)
                        .cornerRadius(5)
                }
            }
        }
        .navigationTitle("Suppliers")
    }
}


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


struct SettingsView: View {
    var body: some View {
        Text("Settings")
    }
}

#Preview {
    DashBoard()
}
