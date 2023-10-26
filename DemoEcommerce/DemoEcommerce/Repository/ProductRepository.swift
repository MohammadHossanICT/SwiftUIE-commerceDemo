//
//  ProductRepository.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 25/10/2023.
//

import Foundation

protocol ProductRepository {
    func getList(for url: URL) async throws -> ProductData
}

struct ProductRepositoryImplementation {
    private let networkManager: Fetchable

    init(networkManager: Fetchable) {
        self.networkManager = networkManager
    }
}

extension ProductRepositoryImplementation: ProductRepository, JsonParser {
    func getList(for url: URL) async throws -> ProductData {
        do {
            let listsData = try await networkManager.get(url: url)
            return try parse(data: listsData, type: ProductData.self)
        } catch {
            throw error
        }
    }
}
