//
//  SmartPhoneCategoryViewCell.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 27/10/2023.
//

import SwiftUI

struct SmartPhoneCategoryViewCell: View {
    let productData: Product
    @StateObject var viewModel = CategorytListViewModel(repository: CategoryRepositoryImplementation(networkManager: NetworkManager()))

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

                Text("Discount: £" + (String(productData.discountPercentage)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20))

                Text("Price: £" + String(productData.price))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20))
            }
        }
        .padding(10)
        .background(.blue)
        .cornerRadius(9)
        .font(.system(size: 23))
        .frame(height: 100)

    }
}

struct SmartPhoneCategoryViewCell_Previews: PreviewProvider {
    static var previews: some View {
        SmartPhoneCategoryViewCell(productData: Product(id: 1, title: "test", description: "test", price: 21, discountPercentage: 11, rating: 12, stock: 3, brand: "test", category: "test", thumbnail: "https://i.dummyjson.com/data/products/1/thumbnail.jpg", images: []))
    }
}
