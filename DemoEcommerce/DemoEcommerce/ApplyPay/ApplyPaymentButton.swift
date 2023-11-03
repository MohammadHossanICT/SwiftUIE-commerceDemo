//
//  ApplyPaymentButton.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 03/11/2023.
//

import SwiftUI
import PassKit

struct ApplyPaymentButton: View {
    var action: () -> Void
    var body: some View {
        Representable(action: action)
            .frame(width: 300, height: 50)
    }
}

struct ApplyPaymentButton_Previews: PreviewProvider {
    static var previews: some View {
        ApplyPaymentButton(action: {})
    }
}

extension ApplyPaymentButton {

    struct Representable: UIViewRepresentable {
        var action: () -> Void

        func makeCoordinator() -> Coordinator {
            Coordinator(action: action)
        }
        func makeUIView(context: Context) -> some UIView {
            context.coordinator.button
        }
        func updateUIView(_ uiView: UIViewType, context: Context) {
            context.coordinator.action = action
        }
    }

    class Coordinator: NSObject {

        var action: () -> Void
        var button = PKPaymentButton(paymentButtonType: .checkout, paymentButtonStyle: .automatic)

        init(action: @escaping () -> Void) {
            self.action = action
            super.init()

            button.addTarget(self, action: #selector(callback(_:)), for: .touchUpInside)
        }
        @objc
        func callback(_ sender: Any) {
            action()
        }
    }
}
