//
//  ProductAsyncImageView.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 25/10/2023.
//

import SwiftUI

struct ProductAsyncImageView: View {
    let url: URL
    private let imageWidth = 150.0
    private let cellHeight = 150.0

    var body: some View {
        CacheAsyncImage(
            url: url) { phase in
                switch phase {
                case .success(let image):
                    VStack {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imageWidth)
                            .padding(.trailing, 10)
                        Spacer()
                    }
                case .failure:
                    Image("placeholder-image")

                case .empty:
                    HStack(alignment: .center) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .red))
                    }
                @unknown default:
                    Image("placeholder-image")
                }
            }
    }
}




