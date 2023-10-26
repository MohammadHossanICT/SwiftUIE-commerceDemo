//
//  ProductListViewCell.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 25/10/2023.
//

import SwiftUI

struct ProductListViewCell: View {

    let productData: Product

    var body: some View {
        HStack {
            if let url = URL(string: productData.thumbnail) {
                ProductAsyncImageView(url: url)
                    .frame(width: 150, height: 150)
                    .mask(RoundedRectangle(cornerRadius: 16))
            }
            VStack(alignment: .leading,spacing: 5){
                Text("Name: " +  (productData.title))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)

                Text("Description: " + (productData.description))
                    .frame(maxWidth: .infinity, alignment: .leading)


                Text("Price: £" + String(productData.price))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
            }
        }
    }
}

struct ProductListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductListViewCell(productData: Product(id: 1, title: "test", description: "test", price: 21, discountPercentage: 11, rating: 12, stock: 3, brand: "test", category: "test", thumbnail: "https://i.dummyjson.com/data/products/1/thumbnail.jpg", images: []))

    }
}
