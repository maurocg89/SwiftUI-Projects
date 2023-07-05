//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Mauro Grillo on 03/07/2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderWrapper: OrderWrapper

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderWrapper.order.name)
                TextField("Street address", text: $orderWrapper.order.streetAddress)
                TextField("City", text: $orderWrapper.order.city)
                TextField("Zip", text: $orderWrapper.order.zip)
                    .keyboardType(.numberPad)
            }

            Section {
                NavigationLink {
                    CheckoutView(orderWrapper: orderWrapper)
                } label: {
                     Text("Check out")
                }
            }
            .disabled(!orderWrapper.order.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderWrapper: OrderWrapper())
    }
}
