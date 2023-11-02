//
//  ProductData.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 25/10/2023.
//

import Foundation

// MARK: - Welcome
struct ProductData: Codable, Hashable {
    let carts: [Cart]
}

// MARK: - Cart
struct Cart: Codable, Hashable {
    let id: Int
    let products: [Product]
}

// MARK: - Product
struct Product: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    var price, quantity, total: Int
    let discountPercentage: Double
    let discountedPrice: Int
    let thumbnail: String
}

extension Product {
    
    var subTotal: Double {
        Double(quantity * price)
    }
}
