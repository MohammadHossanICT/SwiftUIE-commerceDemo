//
//  DemoEcommerceApp.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 19/10/2023.
//

import SwiftUI
import Firebase

@main
struct DemoEcommerceApp: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject var order = Order()

    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
           ContentViewOne()
                .environmentObject(viewModel)
                .environmentObject(order)
        }
    }
}
