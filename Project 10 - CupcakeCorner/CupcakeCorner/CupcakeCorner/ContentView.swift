//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Mauro Grillo on 07/06/2023.
//

import SwiftUI

struct ContentView: View {
//    @StateObject var orderWrapper = OrderWrapper()
    @State private var order = Order()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }

                Section {
                    Toggle("Any special request?", isOn: $order.specialRequestEnabled.animation())

                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }

                Section {
                    NavigationLink("Delivery details") {
//                        AddressView(orderWrapper: orderWrapper)
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }

    }
}

#Preview {
    ContentView()
}
