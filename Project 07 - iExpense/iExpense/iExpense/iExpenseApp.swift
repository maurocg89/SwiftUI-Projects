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
//            ContentView()
            // MARK: Project 12 SwiftData. Challenge 1
            ContentViewSD()
        }
        .modelContainer(for: Expense.self)
    }
}
