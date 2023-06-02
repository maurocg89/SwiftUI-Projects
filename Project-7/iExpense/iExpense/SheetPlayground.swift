//
//  SheetPlayground.swift
//  iExpense
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct SheetPlayground: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Tom")
        }
    }
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String

    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct SheetPlayground_Previews: PreviewProvider {
    static var previews: some View {
        SheetPlayground()
    }
}
