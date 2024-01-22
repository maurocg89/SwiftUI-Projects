//
//  SettingsView.swift
//  DiceRoller
//
//  Created by Mauro Grillo on 17/01/2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showingAlert = false
    @Binding var saveScores: Bool
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
                        UserDefaults.standard.setValue(dicesAmount, forKey: Score.dicesAmountKey)
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
                            ForEach(1...Score.maximumCapacity, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .onChange(of: totalSavedScores) { _ in
                            UserDefaults.standard.setValue(totalSavedScores, forKey: Score.totalScoresKey)
                        }
                    }
                }

                Section {
                    Button("Reset Data", role: .destructive) {
                        showingAlert = true
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
            .alert("Are you sure you want to reset the data?", isPresented: $showingAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    FileManager().resetData(Score.savedFileName)
                }
            }
        }
    }
}

#Preview {
    SettingsView(saveScores: .constant(true), dicesAmount: .constant(1), totalSavedScores: .constant(.random(in: 1...20)), onSelection: nil)
}
