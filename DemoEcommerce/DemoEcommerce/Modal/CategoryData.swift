//
//  CategoryData.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 01/11/2023.
//

import Foundation
// MARK: - Welcome
struct CategoryData: Codable, Hashable {
    let productCategory: [Category]
}

// MARK: - Product
struct Category: Codable, Hashable, Identifiable {
    let id: Int
    var title, description: String
    var price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
