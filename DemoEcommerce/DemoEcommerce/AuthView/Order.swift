//
//  Order.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 30/10/2023.
//

import SwiftUI

class Order: ObservableObject {

    @Published var product = [Product]()

    var total: Int {
        if product.count > 0 {
            return product.reduce(0) { $0 + $1.price }
        } else {
            return 0
        }
    }

//    func add(item: Product) {
//           var exists = false
//           product.forEach { product in
//               if product.id == item.id {
//                   exists = true
//                   product.quantity? += Int(1)
//               }
//           }
//
//           if !exists {
//               product.append(item)
//           }
//       }
    func add(item: Product) {
        if let ndx = product.firstIndex(where: { $0.id == item.id }) {
            // already have this cart/item, do an update here
            product[ndx].title = item.title
            product[ndx].price = item.price
        } else {
            product.append(item)
        }
    }

    func remove(item: Product) {
        if let index = product.firstIndex(of: item) {
            product.remove(at: index)
        }
    }
}
