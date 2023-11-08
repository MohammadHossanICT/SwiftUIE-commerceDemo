//
//  DemoEcommerceApp.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 19/10/2023.
//

import SwiftUI
import Firebase
import Stripe

@main
struct DemoEcommerceApp: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject var order = Order()
    @StateObject var favorites = Favorites()


    init() {
        FirebaseApp.configure()
        StripeAPI.defaultPublishableKey = "sk_test_Nld8gSkdLkvjV2evbgeyej2600qPfVtDJ2"
    }
    var body: some Scene {
        WindowGroup {
           ContentViewOne()
                .environmentObject(viewModel)
                .environmentObject(order)
                .environmentObject(favorites)
        }
    }
}
