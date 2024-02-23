//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Mauro Grillo on 06/05/2023.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            // MARK: Project 12 SwiftData. Challenge 1
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
