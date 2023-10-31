//
//  OrderView.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 27/10/2023.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(order.product) { item in
                        Section {
                            HStack {
                                Text("Description")
                                    .foregroundColor(.blue)
                                    .bold()
                                Spacer()
                                Text("Action")
                                    .foregroundColor(.blue)
                                    .bold()
                                Spacer()
                                Text("Total")
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
                                Image(systemName: "plus.circle")
                                Spacer()
                                Image(systemName: "minus.circle")
                                Spacer()
                                Image(systemName: "trash")
                                    .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                                    .onTapGesture {
                                        order.remove(item: item)
                                    }
                            }
                            Spacer()
                        }

                        VStack {
                            Text("Name: \(item.title)")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .bold()
                            Text("Price: £\(item.price)")
                                .font(.subheadline)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                Section {
                    NavigationLink("Place Order") {
                    }
                }
            }
            .navigationTitle("Order")
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Order())
    }
}
