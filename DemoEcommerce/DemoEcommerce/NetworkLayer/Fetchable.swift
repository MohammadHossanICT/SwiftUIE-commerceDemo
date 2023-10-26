//
//  Fetchable.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 25/10/2023.
//

import Foundation

protocol Fetchable {
    func get(url: URL) async throws -> Data
}
