//
//  DashBoard FIle.swift
//  Street Food Finder
//
//  Created by Prosperity on 13/4/2026.
//

import SwiftUI

struct Food: Identifiable {
    let id = UUID()
    var name: String
    var vendor : String
    var price : Double
    var description: String
    var image: String
    var reviews: [Review]
    
    var averageRating: Double {
        guard !reviews.isEmpty else { return 0 }
        let total = reviews.reduce(0) { $0 + $1.rating }
        return (Double(total) / Double(reviews.count) * 10).rounded() / 10
    }
    let latitude: Double
       let longitude: Double
       let rating: Double
   }


