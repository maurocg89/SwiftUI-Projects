//
//  OnDeletePlayground.swift
//  iExpense
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct OnDeletePlayground: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct OnDeletePlayground_Previews: PreviewProvider {
    static var previews: some View {
        OnDeletePlayground()
    }
}
