//
//  ProductistViewModel.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 25/10/2023.
//

import Foundation

protocol ProductListViewModelAction: ObservableObject {
    func getProductList(urlStr: String) async
}

@MainActor
final class ProductListViewModel {

    @Published private(set) var productLists: [Product] = []
    @Published private(set) var customError: NetworkError?
    @Published private(set) var refreshing = true
    @Published var isErrorOccured = false

    private let repository: ProductRepository
    init(repository: ProductRepository) {
        self.repository = repository
    }
}
extension ProductListViewModel: ProductListViewModelAction {
    func getProductList(urlStr: String) async {
            refreshing = true
            guard let url = URL(string: urlStr) else {
            self.customError = NetworkError.invalidURL
            refreshing = false
            isErrorOccured = false
            return
        }
        do {
            let lists = try await repository.getList(for: url)
            refreshing = false
            isErrorOccured = false
            productLists = lists.products

        } catch {
            refreshing = false
            isErrorOccured = true
            customError = error as? NetworkError
        }
    }
}
