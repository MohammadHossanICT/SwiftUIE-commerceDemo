//
//  MainView.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 25/10/2023.
//

import SwiftUI

struct MainView: View {

    @StateObject var viewModel = ProductListViewModel(repository: ProductRepositoryImplementation(networkManager: NetworkManager()))
   @EnvironmentObject var  order: Order

    var body: some View {
        TabView {
            ProductListView(viewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            CategoryView()
                .tabItem {
                    Label("Category", systemImage: "list.dash")
                }
            OrderView()
                .tabItem {
                  Label("Cart", systemImage: "cart")
                }
                .badge(order.product.count)

            ProfileView()
                .tabItem {
                    Label("Profile ", systemImage: "gear")
                    
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
