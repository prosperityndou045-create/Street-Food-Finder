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
                Food(name: "Burger", vendor: "Foodies Hub", price: 5.99, description: "Juicy burger", image: "fork.knife", reviews: [], latitude: -17.8292, longitude: 31.0522, rating: 4.5),

                Food(name: "Pizza", vendor: "Pizza Palace", price: 8.49, description: "Cheesy pizza", image: "fork.knife", reviews: [], latitude: -17.8310, longitude: 31.0450, rating: 4.8),

                Food(name: "Chicken", vendor: "Grill House", price: 6.75, description: "Grilled chicken", image: "fork.knife", reviews: [], latitude: -17.8350, longitude: 31.0600, rating: 4.2)
            ]
   
    @State private var showAddFood = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(foods.indices, id: \.self) { index in
                    NavigationLink(destination: FoodDetailView(food: $foods[index])) {
                        HStack {
                            
                            
                            Image(systemName: foods[index].image)
                                .font(.system(size: 35))
                                .frame(width: 50, height: 50)
                                .foregroundColor(.orange)
                            
                            VStack(alignment: .leading) {
                                Text(foods[index].name)
                                    .font(.headline)
                                
                                Text("⭐ \(foods[index].averageRating, specifier: "%.1f")")
                                    .foregroundColor(.orange)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("Food Reviews")
            .toolbar {
                Button(action: { showAddFood = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddFood) {
                AddFoodView(foods: $foods)
            }
        }
    }
}

struct FoodDetailView: View {
    @Binding var food: Food
    @State private var showAddReview = false
    
    var body: some View {
        VStack {
          
            Text(food.image)
                .font(.system(size: 80))
//            
            Text(food.name)
                .font(.largeTitle)
            
            Text(food.description)
                .padding()
            
   
            VStack {
                StarRatingView(rating: .constant(Int(food.averageRating.rounded())))
                
                Text("Average Rating: \(food.averageRating, specifier: "%.1f")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.bottom)
            
            Text("Reviews: \(food.reviews.count)")
                .font(.headline)
            
            if food.reviews.isEmpty {
                Text("No reviews yet 😔")
                    .foregroundColor(.gray)
                    .padding()
            }
            
            List(food.reviews) { review in
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(review.username)
                            .font(.headline)
                        
                        Spacer()
                        
              
                        Text(String(repeating: "⭐️", count: review.rating))
                    }
                    
                    Text(review.comment)
                        .font(.body)
                }
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
            
            Button("Add Review") {
                showAddReview = true
            }
            .buttonStyle(.borderedProminent)
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
                ToolbarItem(placement: .topBarTrailing) {
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
                }
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

                TextField("Price", value: $price, format: .number)
            }
            .navigationTitle("Add Food")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        guard !name.isEmpty, !vendor.isEmpty else { return }

                        let newFood = Food(
                            name: name,
                            vendor: vendor,
                            price: price,
                            description: description,
                            image: image,
                            reviews: [],
                            latitude: -17.82,
                            longitude: 31.05,
                            rating: 0.0
                        )

                        foods.append(newFood)
                        dismiss()
                    }
                }
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
