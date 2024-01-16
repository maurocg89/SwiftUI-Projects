//
//  EditCards.swift
//  Flashzilla
//
//  Created by Mauro Grillo on 08/01/2024.
//

import SwiftUI

struct EditCards: View {
    enum FocusedField {
        case prompt, answer
    }

    @Environment(\.dismiss) var dismiss

    @State private var cardList = Array<Card>()
    @State private var newCardPrompt = ""
    @State private var newCardAnswer = ""
    @FocusState var focused: FocusedField?

    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newCardPrompt)
                        .focused($focused, equals: .prompt)
                    TextField("Answer", text: $newCardAnswer)
                        .focused($focused, equals: .answer)
                    Button("Add Card") {
                        addCard()
                    }
                    .disabled(newCardAnswer.isEmpty || newCardPrompt.isEmpty)
                }
                
                Section {
                    ForEach(0..<cardList.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cardList[index].prompt)
                                .font(.headline)

                            Text(cardList[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    } // ForEach
                    .onDelete(perform: deleteAt(at:))
                }
            } // List
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done") {
                    saveData()
                    dismiss()
                }
            }
            .listStyle(.grouped)
            .onAppear {
                loadData()
            }
        }
    }

    private func addCard() {
        let trimmedPrompt = newCardPrompt.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAnswer = newCardAnswer.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else { return }

        let card = Card(id: UUID(), prompt: newCardPrompt, answer: newCardAnswer)
        cardList.insert(card, at: 0)
        saveData()

        // Challenge 1. Clear TextFields
        newCardPrompt = ""
        newCardAnswer = ""
        self.focused = .prompt
    }

    private func deleteAt(at offsets: IndexSet) {
        withAnimation {
            cardList.remove(atOffsets: offsets)
        }
        saveData()
    }

    private func loadData() {
//        if let data = UserDefaults.standard.data(forKey: Card.savedFileName) {
//            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
//                self.cardList = decoded
//            }
//        }
        // Challenge 4. Load from Documents folder
        self.cardList = FileManager().getData(Card.savedFileName) ?? []
    }

    private func saveData() {
//        if let data = try? JSONEncoder().encode(cardList) {
//            UserDefaults.standard.set(data, forKey: Card.savedFileName)
//        }
        // Challenge 4. Save to Documents folder
        FileManager().saveData(Card.savedFileName, cardList)
    }
}

#Preview {
    EditCards()
}
