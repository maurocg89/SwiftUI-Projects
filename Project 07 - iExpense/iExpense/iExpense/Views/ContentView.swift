//
//  ContentView.swift
//  iExpense
//
//  Created by Mauro Grillo on 06/05/2023.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ExpenseSection(title: "Personal", expenses: expenses.personalItems, deleteItems: removePersonalItems(at:))
                
                ExpenseSection(title: "Business", expenses: expenses.businessItems, deleteItems: removeBusinessItems(at:))
            }
            .navigationTitle("iExpense")
            .toolbar {
                // MARK: Project 9 Challenge 1
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Image(systemName: "plus")
                }
//                Button {
//                    showingAddExpense = true
//                } label: {
//                    Image(systemName: "plus")
//                }
            }
//            .sheet(isPresented: $showingAddExpense) {
//                AddView(expenses: expenses)
//            }
        }
    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectsToDelete = IndexSet()
        
        for offset in offsets {
            let item = inputArray[offset]
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }
        
        expenses.items.remove(atOffsets: objectsToDelete)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalItems)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessItems)
    }
}

struct ExpenseItemView: View {
    let item: ExpenseItem
    
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

struct ExpenseSection: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                ExpenseItemView(item: item)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("\(item.name) ^[\(item.amount.formatted()) Dollar](inflect: true)")
            }
            .onDelete(perform: deleteItems)
        }
    }
}

struct CapsuleAmountText: View {
    let amount: Double
    private let currencyFormat: FloatingPointFormatStyle<Double>.Currency =
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var body: some View {
        Text(amount, format: currencyFormat)
            .font(.headline)
            .padding(10)
            .foregroundColor(.white)
            .background(backgroundColor())
            .clipShape(Capsule())
    }
    
    func backgroundColor() -> Color {
        amount < 10.0 ? .green.opacity(0.8) : amount > 100 ? .red.opacity(0.6) : .blue.opacity(0.8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
