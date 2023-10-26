//
//  MainView.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 25/10/2023.
//

import SwiftUI

struct MainView: View {

    @StateObject var viewModel = ProductListViewModel(repository: ProductRepositoryImplementation(networkManager: NetworkManager()))


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
            ListOfcategoriesView()
                .tabItem {
                    Label("List Category ", systemImage: "list.dash")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
