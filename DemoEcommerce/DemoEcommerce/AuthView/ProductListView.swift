//
//  HomeScreenView.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 25/10/2023.
//

import SwiftUI

struct ProductListView: View {
    
    @StateObject var viewModel = ProductListViewModel(repository: ProductRepositoryImplementation(networkManager: NetworkManager()))
    @State var searchText = ""

    var body: some View {

        NavigationStack {
            VStack {
                if viewModel.customError != nil && !viewModel.refreshing {
                    alertView()
                } else {
                    if viewModel.refreshing {
                        progressView()
                    }
                    if viewModel.productLists.count > 0 && !viewModel.refreshing {

                        List(viewModel.productList, id: \.self) { product in
                            ProductListViewCell(productData: product)

                        } .listStyle(.grouped)
                    }
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText, perform: viewModel.performSearch)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    getToolBarView()
                }
            }
            .navigationTitle(Text("Product List"))
        }.task {
            await getDataFromAPI()
        }
        .refreshable {
            await getDataFromAPI()
        }
    }

    func getDataFromAPI() async {
        await viewModel.getProductList(urlStr: NetworkURL.productUrl)
    }

    @ViewBuilder
    func getToolBarView() -> some View {
        Button {
            Task{
                await getDataFromAPI()
            }
        } label: {
            HStack {
                Image(systemName: "arrow.clockwise")
                    .padding(.all, 10.0)
            }.fixedSize()
        }
        .cornerRadius(5.0)
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

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(viewModel: ProductListViewModel(repository: ProductRepositoryImplementation(networkManager: NetworkManager())))
    }
}
