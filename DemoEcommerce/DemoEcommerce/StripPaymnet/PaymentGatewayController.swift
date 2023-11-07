//
//  PaymentGatewayController.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 06/11/2023.
//

import Foundation
import UIKit
import Stripe

class PaymentGatewayController: UIViewController {


    func submitPayment (intent : STPPaymentIntentParams, completion: @escaping (STPPaymentHandlerActionStatus, STPPaymentIntent?, NSError?) -> Void) {
        let paymentHandler = STPPaymentHandler.shared()
        paymentHandler.confirmPayment(intent, with: self) { (status, intent, error) in
            completion(status, intent, error)
        }
    }
}

extension PaymentGatewayController: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}
