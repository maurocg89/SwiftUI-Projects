//
//  OrderModel.swift
//  CupcakeCornerLegacy
//
//  Created by Mauro Grillo on 21/03/2024.
//

import Foundation

struct OrderModel: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var hasValidAddress: Bool {
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        // complicated cake cost more
        cost += (Double(type) / 2)
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
