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

    var colors: [Color] = [.yellow, .purple, .green, .blue, .teal]

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

                Text("Discount: " + (String(productData.discountPercentage.formatted(.currency(code: "GBP")))))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 15))

                Text("Price: " + String(productData.price.formatted(.currency(code: "GBP"))))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 15))
            }
        }
        .padding(10)
        .background(colors.randomElement() ?? Color.clear)
        .cornerRadius(9)
        .font(.system(size: 23))
        .frame(height: 100)

    }
}

struct SmartPhoneCategoryViewCell_Previews: PreviewProvider {
    static var previews: some View {
        SmartPhoneCategoryViewCell(productData: Product(id: 1, title: "test", price: 12, quantity: 2, total: 300, discountPercentage: 23, discountedPrice: 12, thumbnail: "test"))
    }
}
