//
//  ProductData.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 25/10/2023.
//

import Foundation

// MARK: - Welcome
struct ProductData: Codable, Hashable {
    let products: [Product]
}

// MARK: - Product
struct Product: Codable, Hashable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
