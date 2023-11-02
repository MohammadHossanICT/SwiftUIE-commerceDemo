//
//  CategoryView.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 25/10/2023.
//

import SwiftUI

struct CategoryView: View {

    @StateObject var viewModel = CategorytListViewModel(repository: CategoryRepositoryImplementation(networkManager: NetworkManager()))
    private var categoriesList = ["smartphones","laptops","fragrances","skincare","groceries","home-decoration","furniture","tops","womens-dresses","womens-shoes","mens-shirts","mens-shoes","mens-watches","womens-watches","womens-bags","womens-jewellery","sunglasses","automotive","motorcycle","lighting"]

    private var colors: [Color] = [.yellow, .purple, .green, .blue, .teal]
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {

        NavigationStack {

            VStack {
                if viewModel.customError != nil && !viewModel.refreshing {
                    alertView()
                } else {
                    if viewModel.refreshing {
                        progressView()
                    }
                    if viewModel.categoryLists.count > 0 && !viewModel.refreshing {

                        Section {
                            Text("Woman Dress")
                                .smartPhoneModifier()

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {

                                    ForEach(viewModel.categoryLists, id: \.self) { category in
                                        SmartPhoneCategoryViewCell(productData: category)
                                    }
                                }
                                .frame(height: 180)
                                .padding(9)
                            }
                        }

                        Section {
                            Text("Product List")
                                .smartPhoneModifier()

                            ScrollView {
                                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                                    ForEach(categoriesList, id: \.self) {
                                        Text($0)
                                            .font(.system(size: 20))
                                            .frame(width: 120, height: 130)
                                            .background(colors.randomElement() ?? .primary)
                                            .cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .frame(maxHeight: 300)
                        }
                    }
                }
            }.navigationTitle(Text("Category List"))
    
        }.task {
            await getDataFromAPI()
        }
        .refreshable {
            await getDataFromAPI()
        }
    }

    func getDataFromAPI() async {
        await viewModel.getCategoryList(urlStr: NetworkURL.productUrl)
    }

    @ViewBuilder
    func progressView() -> some View {
        VStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .frame(height: 180)
                .overlay {
                    VStack {
                        ProgressView().padding(50)
                        Text("Please Wait Message").font(.headline)
                    }
                }
        }
    }

    @ViewBuilder
    func alertView() -> some View {
        Text("").alert(isPresented: $viewModel.isErrorOccured) {
            Alert(title: Text("General_Error"), message: Text(viewModel.customError?.localizedDescription ?? ""),dismissButton: .default(Text("Okay")))
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
