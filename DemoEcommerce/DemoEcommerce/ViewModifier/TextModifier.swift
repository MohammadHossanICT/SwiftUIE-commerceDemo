//
//  TextModifier.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 30/10/2023.
//

import SwiftUI

struct TextModifier: ViewModifier {

    func body(content: Content) -> some View {

        VStack {
            content
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.teal)
                .clipShape(Capsule())
                .padding(10)
        }
    }
}
extension View {
    func smartPhoneModifier() -> some View {
        modifier(TextModifier())
    }
}
