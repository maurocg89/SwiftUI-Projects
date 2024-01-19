//
//  SettingsView.swift
//  DiceRoller
//
//  Created by Mauro Grillo on 17/01/2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var saveScores = false
    @Binding var dicesAmount: Int
    @Binding var totalSavedScores: Int
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

                Section {
                    Toggle("Save scores", isOn: $saveScores)
                        .onChange(of: saveScores) { _ in
                            if !saveScores {
                                totalSavedScores = 1
                            }
                        }
                }

                if saveScores {
                    Section {
                        Picker("Number of scores you want to save", selection: $totalSavedScores) {
                            ForEach(1...20, id: \.self) {
                                Text("\($0)")
                            }
                        }
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
    SettingsView(dicesAmount: .constant(1), totalSavedScores: .constant(.random(in: 1...20)), onSelection: nil)
}
