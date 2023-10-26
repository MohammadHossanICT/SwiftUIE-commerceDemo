//
//  User.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 20/10/2023.
//

import Foundation

struct User: Identifiable , Codable {

    let id: String
    let fullname: String
    let email: String

    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}
