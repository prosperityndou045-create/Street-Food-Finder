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
    var user: User = .init(name: "John Doe", email: "john@example.com")

    @State private var foods: [Food] = [
        Food(name: "Burger", vendor: "Foodies Hub", price: 5.99, description: "Juicy burger", image: "burger", reviews: [], latitude: -17.8292, longitude: 31.0522, rating: 4.5),
        Food(name: "Pizza", vendor: "Pizza Palace", price: 8.49, description: "Cheesy pizza", image: "pizza", reviews: [], latitude: -17.8310, longitude: 31.0450, rating: 4.8),
        Food(name: "Chicken", vendor: "Grill House", price: 6.75, description: "Grilled chicken", image: "chicken", reviews: [], latitude: -17.8350, longitude: 31.0600, rating: 4.2)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.brown.opacity(0.15).ignoresSafeArea()

                VStack(alignment: .leading, spacing: 20) {

                    header
                    searchBar

                    VStack(spacing: 15) {

                        NavigationLink(destination: CustomersView(user: user,foods: foods)) {
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

                    Text("Featured Foods")
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
                .foregroundColor(.blue)
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

                        Image(food.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 70)

                        Text(food.name)
                            .font(.headline)

                        Text("$\(food.price, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.black)
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

                withAnimation(.linear(duration: 25).repeatForever(autoreverses: false)) {
                    offset = -totalWidth
                }
            }
        }
        .frame(height: 140)
        .clipped()
    }
}
struct SettingsView: View{
    var body: some View{
        Text("Settings")
    }
}
#Preview {
    DashBoard()
}
