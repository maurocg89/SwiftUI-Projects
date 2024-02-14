//
//  ContentViewSD.swift
//  iExpense
//
//  Created by Mauro Grillo on 13/02/2024.
//

import SwiftData
import SwiftUI

struct ContentViewSD: View {
    @Environment(\.modelContext) var modelContext
    @Query var expensesItems: [Expense]
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            List {
                ExpenseSectionSD(title: "Personal", expenseType: "Personal", deleteItems: removePersonalItems(at:))
                ExpenseSectionSD(title: "Business", expenseType: "Business", deleteItems: removeBusinessItems(at:))
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddViewSD()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    func removeItems(at offsets: IndexSet, in inputArray: [Expense]) {
        for offset in offsets {
            let item = inputArray[offset]
            if let index = expensesItems.firstIndex(of: item) {
                modelContext.delete(expensesItems[index])
            }
        }
    }

    func removePersonalItems(at offsets: IndexSet) {
        let personalItems = expensesItems.filter({ $0.type == "Personal" })
        removeItems(at: offsets, in: personalItems)
    }

    func removeBusinessItems(at offsets: IndexSet) {
        let businessItems = expensesItems.filter({ $0.type == "Business" })
        removeItems(at: offsets, in: businessItems)
    }
}

struct ExpenseItemViewSD: View {
    let item: Expense

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }

            Spacer()

            CapsuleAmountText(amount: item.amount)
        }
    }
}

struct ExpenseSectionSD: View {
    @Query let expenses: [Expense]
    let title: String
    let deleteItems: (IndexSet) -> Void

    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                ExpenseItemViewSD(item: item)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("\(item.name) ^[\(item.amount.formatted()) Dollar](inflect: true)")
            }
            .onDelete(perform: deleteItems)
        }
    }

    init(title: String, expenseType: String, deleteItems: @escaping (IndexSet) -> Void) {
        self.title = title
        self.deleteItems = deleteItems
        _expenses = Query(filter: #Predicate<Expense> { expense in
            expense.type.contains(expenseType)
        })
    }
}

#Preview {
    ContentViewSD()
}
