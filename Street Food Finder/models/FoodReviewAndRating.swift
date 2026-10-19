//
//  FoodReviewAndRating.swift
//  Street Food Finder
//
//  Created by Prosperity on 30/3/2026.

import SwiftUI

struct Review: Identifiable {
    let id = UUID()
    var username: String
    var rating: Int
    var comment: String
}

struct ContentView: View {
    @State private var foods: [Food] = [
        Food(name: "Burger",
             vendor: "Foodies Hub",
             price: 5.99,
             description: "Juicy burger",
             image: "burger",
             reviews: [],
             latitude: -17.8292,
             longitude: 31.0522,
             rating: 4.5),

        Food(name: "Pizza",
             vendor: "Pizza Palace",
             price: 8.49,
             description: "Cheesy pizza",
             image: "pizza",
             reviews: [],
             latitude: -17.8310,
             longitude: 31.0450,
             rating: 4.8),

        Food(name: "Chicken",
             vendor: "Grill House",
             price: 6.75,
             description: "Grilled chicken",
             image: "chicken",
             reviews: [],
             latitude: -17.8350,
             longitude: 31.0600,
             rating: 4.2)
    ]

    @State private var showAddFood = false

    var body: some View {
        NavigationView {
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

                List {
                    ForEach(foods.indices, id: \.self) { index in
                        NavigationLink(destination: FoodDetailView(food: $foods[index])) {

                            HStack(spacing: 12) {
                                Image(foods[index].image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .cornerRadius(8)

                                VStack(alignment: .leading) {
                                    Text(foods[index].name)
                                        .font(.headline)

                                    HStack {
                                        ForEach(1...5, id: \.self) { number in
                                            Image(systemName: number <= Int(foods[index].averageRating.rounded()) ? "star.fill" : "star")
                                                .foregroundColor(.orange)
                                        }

                                        Text("\(foods[index].averageRating, specifier: "%.1f")")
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Food Reviews")
                .toolbar {
                    Button {
                        showAddFood = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showAddFood) {
                    AddFoodView(foods: $foods)
                }
            }
        }
    }
}

struct FoodDetailView: View {
    @Binding var food: Food
    @State private var showAddReview = false

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

            VStack(spacing: 10) {

                Image(food.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
                    .cornerRadius(12)
                    .padding()

                Text(food.name)
                    .font(.largeTitle)
                    .bold()

                Text(food.description)
                    .padding()

                VStack {
                    StarRatingView(rating: .constant(Int(food.averageRating.rounded())))

                    Text("Average Rating: \(food.averageRating, specifier: "%.1f")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Text("Reviews: \(food.reviews.count)")
                    .font(.headline)

                if food.reviews.isEmpty {
                    Text("No reviews yet")
                        .foregroundColor(.gray)
                } else {
                    List(food.reviews) { review in
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text(review.username)
                                    .font(.headline)

                                Spacer()

                                HStack {
                                    ForEach(0..<review.rating, id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.orange)
                                    }
                                }
                            }

                            Text(review.comment)
                        }
                        .padding(10)
                        .background(Color.brown.opacity(0.1))
                        .cornerRadius(10)
                    }
                }

                Button("Add Review") {
                    showAddReview = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .padding()
            }
            .padding()
        }
        .navigationTitle(food.name)
        .sheet(isPresented: $showAddReview) {
            AddReviewView(food: $food)
        }
    }
}

struct AddReviewView: View {
    @Binding var food: Food
    @Environment(\.dismiss) var dismiss

    @State private var username = ""
    @State private var rating = 3
    @State private var comment = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Your Info") {
                    TextField("Your name", text: $username)
                }

                Section("Rating") {
                    StarRatingView(rating: $rating)
                }

                Section("Comment") {
                    TextField("Write your review...", text: $comment)
                }
            }
            .navigationTitle("Add Review")
            .toolbar {
                Button("Submit") {
                    guard !username.isEmpty, !comment.isEmpty else { return }

                    let newReview = Review(
                        username: username,
                        rating: rating,
                        comment: comment
                    )

                    food.reviews.append(newReview)
                    dismiss()
                }
                .tint(.brown)
            }
        }
    }
}

struct AddFoodView: View {
    @Binding var foods: [Food]
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var description = ""
    @State private var image = ""
    @State private var price: Double = 0.0
    @State private var vendor = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Food name", text: $name)
                TextField("Description", text: $description)
                TextField("Vendor", text: $vendor)
                TextField("Image name", text: $image)
                TextField("Price", value: $price, format: .number)
            }
            .navigationTitle("Add Food")
            .toolbar {
                Button("Save") {
                    guard !name.isEmpty, !vendor.isEmpty else { return }

                    let newFood = Food(
                        name: name,
                        vendor: vendor,
                        price: price,
                        description: description,
                        image: image.isEmpty ? "burger" : image,
                        reviews: [],
                        latitude: -17.82,
                        longitude: 31.05,
                        rating: 0.0
                    )

                    foods.append(newFood)
                    dismiss()
                }
                .tint(.brown)
            }
        }
    }
}

struct StarRatingView: View {
    @Binding var rating: Int
    var maxRating: Int = 5

    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { number in
                Image(systemName: number <= rating ? "star.fill" : "star")
                    .foregroundColor(.orange)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
