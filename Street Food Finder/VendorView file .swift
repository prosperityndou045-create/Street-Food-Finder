//
//  VendorView file .swift
//  Street Food Finder
//
//  Created by Prosperity on 14/4/2026.
//

import SwiftUI
import MapKit

struct Vendor: Identifiable {
    let id = UUID()   
    let name: String
    let businessName: String
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
