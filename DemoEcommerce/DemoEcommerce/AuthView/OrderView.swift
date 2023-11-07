//
//  OrderView.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 27/10/2023.
//

import SwiftUI
import Stripe

struct OrderView: View {
    @EnvironmentObject var order: Order
    private var fee: Double = 5.00
    @State private var isOn1 = false
    @State private var isOn2 = false
    @State private var message: String = ""
    @State private var isSuccess: Bool = false
    @State private var paymentMethodParams: STPPaymentMethodParams?
    let paymentGatewayController = PaymentGatewayController()

    var body: some View {

        NavigationStack {
            
            List {
                Section {
                    ForEach.init($order.products) { $item in
                        Section {
                            HStack {
                                Text("Description")
                                    .foregroundColor(.blue)
                                    .bold()
                                Spacer()
                                Text("Action")
                                    .foregroundColor(.blue)
                                    .bold()
                            }
                        }

                        HStack {
                            if let url = URL(string: item.thumbnail) {
                                ProductAsyncImageView(url: url)
                                    .frame(width: 90, height: 90)
                                    .padding(.bottom, -10)
                                    .clipShape(Circle())
                            }
                            Spacer()

                            VStack {
                                HStack {
                                    Stepper {
                                        Text("\(Image(systemName: "multiply"))\(item.quantity)")

                                    }
                                onIncrement: {
                                    item.quantity += 1
                                    self.order.calculateTotal()

                                }
                                onDecrement: {
                                    if item.quantity > 1 {
                                        item.quantity -= 1
                                        self.order.calculateTotal()
                                    }
                                }
                                Image(systemName: "trash")
                                    .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                                    .onTapGesture {
                                    order.remove(item: item)
                                    }
                                }
                            }
                            Spacer()
                        }
                        VStack {
                            HStack(spacing: 20) {
                                Text("Name: \(item.title)")
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .bold()
                            }
                            HStack {
                                Text("Price: \(item.price.formatted(.currency(code: "GBP")))")
                                    .font(.subheadline)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Text("Sub Total: \(item.subTotal, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    HStack {
                        Text("Your cart total is :")
                            .bold()
                        Spacer()
                        Text("\(order.productTotal.formatted(.currency(code: "GBP")))")
                            .bold()
                    }
                    .padding(5)

                    HStack {
                        Text("Choose Delivery Option")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)

                    }
                    .padding(5)
                    VStack(alignment: .leading) {
                        Toggle("Standard : Free ", isOn: $isOn1)
                            .toggleStyle(CheckboxToggleStyle(style: .circle))
                            .foregroundColor(.blue)
                            .onChange(of: isOn1, perform: {  flag in
                                if flag {
                                    isOn2 = false
                                }
                            })
                            Toggle("Express : Charge \(fee.formatted(.currency(code: "GBP")))", isOn: $isOn2)
                            .toggleStyle(CheckboxToggleStyle(style: .circle))
                            .foregroundColor(.blue)
                            .onChange(of: isOn2, perform: {  flag in
                                if flag {
                                    isOn1 = false
                                }
                            })
                    }

                    HStack {
                        Text("Grand total is :")
                            .bold()
                        Spacer()
                        if isOn2 {

                            Text("\((order.productTotal + fee).formatted(.currency(code: "GBP")))")
                                .bold()

                        } else {
                            Text("\(order.productTotal.formatted(.currency(code: "GBP")))")
                                .bold()
                        }
                    }
                    .padding(5)
                    HStack {
                        ApplyPaymentButton(action: order.applePay)
                    }
                    Section {
                        // Stripe Credit Card TextField Here
                        STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethodParams)
                    } header: {
                        Text("Payment Information")
                    }
                    HStack {
                        Spacer()
                        Button("Pay With Bank Card") {
                            self.pay()
                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                        .padding(.top ,24)
                        
                        Spacer()
                    }
                }
                HStack {
                    Text(message)
                        .font(.headline)
                }
            }
            .navigationTitle("Order")
            .padding(.top)
            .onDisappear {
                if order.paymentSuccess {
                    order.paymentSuccess = false
                }
            }
        }
    }
}
extension   OrderView {
    private func startCheckout(completion: @escaping (String?) -> Void) {

        let url = URL(string: "https://rogue-quartz-ounce.glitch.me/create-payment-intent")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(order.products)

        URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion(nil)
                return
            }

            let checkoutIntentResponse = try? JSONDecoder().decode(CheckoutIntentResponse.self, from: data)
            completion(checkoutIntentResponse?.clientSecret)

        }.resume()

    }
}
extension OrderView {

    private func pay() {

        guard let clientSecret = PaymentConfig.shared.paymentIntentClientSecret else {
            return
        }

        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams

        paymentGatewayController.submitPayment(intent: paymentIntentParams) { status, intent, error in

            switch status {
                case .failed:
                    message = "Failed"
                case .canceled:
                    message = "Cancelled"
                case .succeeded:
                    message = "Your payment has been successfully completed!"
            }

        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Order())
    }
}

