//
//  OrderView.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 27/10/2023.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order
    private var fee: Double = 5.00
    @State private var isOn1 = false
    @State private var isOn2 = false

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

