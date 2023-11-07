//
//  ProductDetailsView.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 07/11/2023.
//

import SwiftUI

struct ProductDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var title: String = ""
    @State private var id: String = ""
    @State private var price: String = ""
    @State private var currentAmount: CGFloat = 0
    @State private var lastAmount: CGFloat = 0



    let product: Product

    var body: some View {
        HStack {
            if let url = URL(string: product.thumbnail) {
                ProductAsyncImageView(url: url)
                    .frame(width: 150, height: 150)
                    .mask(RoundedRectangle(cornerRadius: 16))
                    .gesture(MagnificationGesture()
                        .onChanged { value in
                            currentAmount = value - 1

                        }
                        .onEnded{ value in
                            lastAmount += currentAmount
                            currentAmount = 0
                        }
                    )
            }
            VStack(alignment: .center, spacing: 5) {
                Text("Title: \(product.title)")
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 15))
                Text("ID: \(product.id)")
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 15))
                
                Text("Price: \((product.price).formatted(.currency(code: "GBP")))")
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 15))

            }.onAppear(perform: {
                title = product.title
                id = String(product.id)
                price = String(product.price)
            }).padding(10)
        }.padding(10)
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(product: Product(id: 1, title: "test", price: 12, quantity: 2, total: 23, discountPercentage: 24, discountedPrice: 12, thumbnail: "https://i.dummyjson.com/data/products/59/thumbnail.jpg"))
    }
}
