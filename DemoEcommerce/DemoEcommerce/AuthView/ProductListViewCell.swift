//
//  ProductListViewCell.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 25/10/2023.
//

import SwiftUI

struct ProductListViewCell: View {

    let productData: Product
    @EnvironmentObject var order: Order

    var body: some View {
        HStack {
            if let url = URL(string: productData.thumbnail) {
                ProductAsyncImageView(url: url)
                    .frame(width: 150, height: 150)
                    .mask(RoundedRectangle(cornerRadius: 16))
            }
            VStack(alignment: .leading,spacing: 5) {
                Text("Name: " +  (productData.title))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)

                Text("ID: " + String(productData.id))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)

                Text("Price: " + String(productData.price.formatted(.currency(code: "GBP"))))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)

                Button {
                    order.add(item: productData)
                    
                    startCheckout { clientSecret in
                         PaymentConfig.shared.paymentIntentClientSecret = clientSecret
                     }

                } label: {
                    HStack {
                        Image(systemName: "cart.badge.plus")

                        Text("Add to Cart")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(width: 150 , height: 40)

                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
            }
        }
    }
}

extension   ProductListViewCell {
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
struct ProductListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductListViewCell(productData: Product(id: 1, title: "test", price: 12, quantity: 2, total: 12, discountPercentage: 12.0, discountedPrice: 12, thumbnail: "test"))
            .environmentObject(Order())

    }
}
