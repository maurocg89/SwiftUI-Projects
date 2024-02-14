//
//  Expense.swift
//  iExpense
//
//  Created by Mauro Grillo on 13/02/2024.
//

import SwiftData
import Foundation

@Model
class Expense {
    var name: String
    var type: String
    var amount: Double

    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
