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
                    .padding()
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

