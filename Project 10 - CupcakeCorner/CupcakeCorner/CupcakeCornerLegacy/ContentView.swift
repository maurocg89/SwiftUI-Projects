//
//  ContentView.swift
//  CupcakeCornerLegacy
//
//  Created by Mauro Grillo on 14/03/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var orderWrapper = OrderWrapper()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderWrapper.order.type) {
                        ForEach(OrderModel.types.indices, id: \.self) {
                            Text(OrderModel.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(orderWrapper.order.quantity)", value: $orderWrapper.order.quantity, in: 3...20)
                }

                Section {
                    Toggle("Any special request?", isOn: $orderWrapper.order.specialRequestEnabled.animation())

                    if orderWrapper.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $orderWrapper.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $orderWrapper.order.addSprinkles)
                    }
                }

                Section {
                    NavigationLink {
                        AddressView(orderWrapper: orderWrapper)
                    } label: {
                        Text("Delivery details")
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
