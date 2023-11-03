//
//  Order.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 30/10/2023.
//

import SwiftUI

class Order: ObservableObject {

    @Published var products = [Product]()
    @Published private(set) var productTotal: Double = 0
    // Payment-related variables
    let paymentHandler = PaymentHandler()
    @Published var paymentSuccess = false

    func add(item: Product) {
        if let index = products.firstIndex(where: {$0.id == item.id }) {
            products[index].quantity += 1

        } else {
            products.append(item)
        }
        self.calculateTotal()
    }

    func remove(item: Product) {
        if let index = products.firstIndex(of: item) {
            products.remove(at: index)
            self.calculateTotal()
        }
    }

   func calculateTotal() {
        self.productTotal = self.products.reduce(0.0, { total, item in
            total + Double(item.quantity * item.price)
        })
    }

    // Call the startPayment function from the PaymentHandler. In the completion handler, set the paymentSuccess variable
    func applePay() {
        paymentHandler.startPayment(products: products, total: productTotal) { success in
            self.paymentSuccess = success
            self.products = []
            self.productTotal = 0
        }
    }
}

//
//var total: Int {
//    if products.count > 0 {
//        return products.reduce(0) { $0 + $1.price }
//    } else {
//        return 0
//    }
//}
//extension Order {
//    var subTotal: Double {
//            Double(quantity * price)
//        }
//}
//var productTotal: Int {
//        products.map { $0.quantity * $0.price }.reduce(0, +)
//    }
//var productSubTotal: Double {
//    products.reduce(0.0) { partialResult, p in
//        partialResult + Double(p.quantity * p.price)
//    }
//}

////    mutating func increase(quantity: Int) {
//        self.quantity += quantity
//    }
//    func add(item: Product) {
//        if let index = product.firstIndex(where: { $0.id == item.id }) {
//            var copy = item
//            copy.increase(quantity: 1)
//            product[index] = copy
//        } else {
//            product.append(item)
//        }
//    }
//    func add(item: Product) {
//            var exists = false
//            for i in 0..<product.count where product[i].id == item.id {
//                product[i].quantity += 1
//                exists = true
//            }
//            if !exists {
//                product.append(item)
//            }
//        }
//    func add(item: Product) {
//           var exists = false
//           product.forEach { product in
//               if product.id == item.id {
//                   exists = true
//                   product.quantity += 1
//               }
//           }
//           if !exists {
//               product.append(item)
//           }
//       }
//    func add(item: Product) {
//        if let ndx = product.firstIndex(where: { $0.id == item.id }) {
//            // already have this cart/item, do an update here
//            product[ndx].title = item.title
//            product[ndx].price = item.price
//            product[ndx].quantity += 1
//
//        } else {
//            product.append(item)
//            productTotal += item.price
//        }
//    }
