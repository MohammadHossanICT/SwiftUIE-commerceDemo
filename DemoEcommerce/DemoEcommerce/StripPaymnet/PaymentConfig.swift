//
//  PaymentConfig.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 06/11/2023.
//

import Foundation

class PaymentConfig {

    var paymentIntentClientSecret: String?
    static var shared: PaymentConfig = PaymentConfig()

    private init() { }
}
