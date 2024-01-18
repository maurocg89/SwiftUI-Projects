//
//  SettingsView.swift
//  DiceRoller
//
//  Created by Mauro Grillo on 17/01/2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var dicesAmount: Int
    let onSelection: (() -> Void)?

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("Number of dices", selection: $dicesAmount) {
                        ForEach(1...10, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .onChange(of: dicesAmount) { _ in
                        onSelection?()
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    SettingsView(dicesAmount: .constant(1), onSelection: nil)
}
