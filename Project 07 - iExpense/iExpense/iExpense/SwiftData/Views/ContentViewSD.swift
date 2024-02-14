//
//  ContentViewSD.swift
//  iExpense
//
//  Created by Mauro Grillo on 13/02/2024.
//

import SwiftData
import SwiftUI

struct ContentViewSD: View {
    enum CategoryFilter {
        case all
        case personal
        case business
    }

    @Environment(\.modelContext) var modelContext
    @Query var expensesItems: [Expense]
    @State private var showingAddExpense = false
    // MARK: Project 12 - SwiftData. Challenge 2
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]
    // MARK: Project 12 - SwiftData. Challenge 3
    @State private var categoryFilter: CategoryFilter = .all

    var body: some View {
        NavigationStack {
            expensesSection
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddViewSD()
                } label: {
                    Image(systemName: "plus")
                }
                
                if !expensesItems.isEmpty {
                    Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker("Filter By", selection: $categoryFilter) {
                            Text("All")
                                .tag(CategoryFilter.all)
                            Text("Personal")
                                .tag(CategoryFilter.personal)
                            Text("Business")
                                .tag(CategoryFilter.business)
                        }
                    }

                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\Expense.name),
                                    SortDescriptor(\Expense.amount)
                                ])

                            Text("Sort by Amount")
                                .tag([
                                    SortDescriptor(\Expense.amount),
                                    SortDescriptor(\Expense.name)
                                ])
                        }
                    }
                }

            }
        }
    }

    private var expensesSection: some View {
        Group {
            if !expensesItems.isEmpty {
                List {
                    if categoryFilter == .all || categoryFilter == .personal {
                        ExpenseSectionSD(title: "Personal", expenseType: "Personal", sortOrder: sortOrder, deleteItem: removeItems(expense:))
                    }
                    if categoryFilter == .all || categoryFilter == .business {
                        ExpenseSectionSD(title: "Business", expenseType: "Business", sortOrder: sortOrder, deleteItem: removeItems(expense:))
                    }
                }
            } else {
                ContentUnavailableView("There are no expenses saved", systemImage: "creditcard", description: Text("Tap the '+' button to add new expenses"))
            }
        }
    }

    func removeItems(expense: Expense) {
        modelContext.delete(expense)
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
    let deleteItem: (Expense) -> Void

    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                ExpenseItemViewSD(item: item)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("\(item.name) ^[\(item.amount.formatted()) Dollar](inflect: true)")
                    .swipeActions(edge: .trailing) {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            deleteItem(item)
                        }
                    }
            }
        }
    }

    init(title: String, expenseType: String, sortOrder: [SortDescriptor<Expense>], deleteItem: @escaping (Expense) -> Void) {
        self.title = title
        self.deleteItem = deleteItem
        _expenses = Query(filter: #Predicate<Expense> { expense in
            expense.type.contains(expenseType)
        }, sort: sortOrder)
    }
}

#Preview {
    ContentViewSD()
}
