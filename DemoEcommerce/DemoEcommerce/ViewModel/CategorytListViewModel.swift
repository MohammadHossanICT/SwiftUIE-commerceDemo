//
//  CategorytListViewModel.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 27/10/2023.
//

import Foundation

protocol CategorytListViewModelAction: ObservableObject {
    func getCategoryList(urlStr: String) async
}

@MainActor
final class CategorytListViewModel {

    @Published private(set) var categoryLists: [Product] = []
    @Published private(set) var customError: NetworkError?
    @Published private(set) var refreshing = true
    @Published var isErrorOccured = false

    private let repository: CategoryRepository
    init(repository: CategoryRepository) {
        self.repository = repository
    }
}

extension CategorytListViewModel: CategorytListViewModelAction {
    func getCategoryList(urlStr: String) async {

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
            categoryLists = lists.products

        } catch {
            refreshing = false
            isErrorOccured = true
            customError = error as? NetworkError
        }
    }
}
