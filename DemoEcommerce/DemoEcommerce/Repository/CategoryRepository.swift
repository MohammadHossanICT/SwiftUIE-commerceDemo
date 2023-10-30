//
//  CategoryRepository.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 27/10/2023.
//

import Foundation

protocol CategoryRepository {
    func getList(for url: URL) async throws -> ProductData
}

struct CategoryRepositoryImplementation {
    private let networkManager: Fetchable

    init(networkManager: Fetchable) {
        self.networkManager = networkManager
    }
}

extension CategoryRepositoryImplementation: CategoryRepository, JsonParser {
    func getList(for url: URL) async throws -> ProductData {
        do {
            let listsData = try await networkManager.get(url: url)
            return try parse(data: listsData, type: ProductData.self)
        } catch {
            throw error
        }
    }
}
