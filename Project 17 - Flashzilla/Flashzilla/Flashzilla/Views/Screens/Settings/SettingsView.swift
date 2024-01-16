//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Mauro Grillo on 09/01/2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var retryIncorrectCards: Bool

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text("Retry incorrect cards")
                        Toggle("", isOn: $retryIncorrectCards)
                    }
                } footer: {
                    Text("If the answer is incorrect, the card will return to the bottom of the stack")
                }
            }
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView(retryIncorrectCards: .constant(false))
}
