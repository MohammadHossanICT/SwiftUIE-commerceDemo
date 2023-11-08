//
//  Favorites.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 07/11/2023.
//

import Foundation
import SwiftUI

class Favorites: ObservableObject {
    
    // the actual products the user has favorites
    
    private var products: Set<String>
    
    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"
    
    init() {
        // load our saved data
        // still here? Use an empty array
        products = []
    }
    
    // returns true if our set contains this resort
    func contains(_ product: Product) -> Bool {
        products.contains(String(product.id))
    }
    
    // adds the resort to our set, updates all views, and saves the change
    func add(_ product: Product) {
        objectWillChange.send()
        products.insert(String(product.id))
        save()
    }
    // removes the resort from our set, updates all views, and saves the change
    func remove(_ product: Product) {
        objectWillChange.send()
        products.remove(String(product.id))
        save()
    }
    
    func save() {
        // write out our data
    }
}
