//
//  ContentView.swift
//  Flashzilla
//
//  Created by Mauro Grillo on 04/01/2024.
//

import SwiftUI

struct ContentView: View {
    enum SheetType {
        case edit, settings, none
    }

    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @Environment(\.scenePhase) var scenePhase

    @State private var cards: Array<Card> = []
    @State private var appIsActive = true
    @State private var timeRemaining = 100
    @State private var showingSheet = false
    @State private var sheetType: SheetType = .none
    @State private var retryIncorrectCards = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            background

            gameView

            sheetButtons

            if differentiateWithoutColor || voiceOverEnabled {

                accessibilityButtons
            }
        } // ZStack
        .onReceive(timer) { time in
            guard appIsActive else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            appIsActive = newPhase == .active && !cards.isEmpty
        }
        .sheet(isPresented: $showingSheet, onDismiss: resetCards) {
            if sheetType == .edit {
                EditCards()
            } else if sheetType == .settings {
                SettingsView(retryIncorrectCards: $retryIncorrectCards)
            }
        }
        .onAppear(perform: resetCards)
    }

    // MARK: Computed Properties Views
    private var background: some View {
        Image("background")
            .resizable()
            .ignoresSafeArea()
    }
    
 // TODO: Show an initial view before starting the game
    private var gameView: some View {
        VStack {
            Text("Time: \(timeRemaining)")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(.black.opacity(0.75))
                .clipShape(.capsule)

            ZStack {
                ForEach(Array(cards.enumerated()), id: \.element.id) { index, element in
                    CardView(card: element, retryIncorrectCards: retryIncorrectCards) { shuffle in
                        withAnimation {
                            removeCard(at: index, shuffle: shuffle)
                        }
                    }
                    .stacked(at: index, in: cards.count)
                    .allowsHitTesting(index == cards.count - 1)
                    .accessibilityHidden(index < cards.count - 1)
                }
            } // ZStack
            .allowsHitTesting(timeRemaining > 0)

            if cards.isEmpty {
                Button("Start Again", action: resetCards)
                    .padding()
                    .background(.white)
                    .foregroundStyle(.black)
                    .clipShape(.capsule)
                    .padding()
            }

        } // VStack

    }

    private var sheetButtons: some View {
        VStack {
            HStack {
                Button {
                    sheetType = .settings
                    showingSheet = true
                } label: {
                    Image(systemName: "gear")
                        .padding()
                        .background(.black.opacity(0.7))
                        .clipShape(.circle)
                }

                Spacer()

                Button {
                    sheetType = .edit
                    showingSheet = true
                } label: {
                    Image(systemName: "plus.circle")
                        .padding()
                        .background(.black.opacity(0.7))
                        .clipShape(.circle)
                }
            } // HStack

            Spacer()
        } // VStack
        .foregroundStyle(.white)
        .font(.largeTitle)
        .padding()
    }

    private var accessibilityButtons: some View {
        VStack {
            Spacer()

            HStack {
                Button {
                    withAnimation {
                        removeCard(at: cards.count - 1, shuffle: true)
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .padding()
                        .background(.black.opacity(0.7))
                        .clipShape(.circle)
                }
                .accessibilityLabel("Wrong")
                .accessibilityHint("Mark your answer as being incorrect")

                Spacer()

                Button {
                    withAnimation {
                        removeCard(at: cards.count - 1, shuffle: false)
                    }
                } label: {
                    Image(systemName: "checkmark.circle")
                        .padding()
                        .background(.black.opacity(0.7))
                        .clipShape(.circle)
                }
                .accessibilityLabel("Correct")
                .accessibilityHint("Mark your answer as being correct")
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
        }
    }
    
    // MARK: Private Methods
    private func loadData() {
//        if let data = UserDefaults.standard.data(forKey: Card.savedFileName) {
//            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
//                self.cards = decoded
//            }
//        }
        // Challenge 4. Load from Documents folder
        self.cards = FileManager().getData(Card.savedFileName) ?? []
        appIsActive = !cards.isEmpty
    }


//    func removeCard(at index: Int) {
//        guard index >= 0 else { return }
//
//        cards.remove(at: index)
//        if cards.isEmpty {
//            appIsActive = false
//        }
//    }

    // Challenge 3. When the users gets an answer wrong, add that card goes back into the array so the user can try it again
    func removeCard(at index: Int, shuffle: Bool) {
        guard index >= 0 else { return }

        let card = cards.remove(at: index)
        if shuffle && retryIncorrectCards {
            if cards.isEmpty {
                cards.append(card)
            } else {
                cards.insert(card, at: 0)
//                cards.insert(card, at: Int.random(in: 0..<cards.count))
            }
            return
        }

        if cards.isEmpty {
            appIsActive = false
        }
    }

    func resetCards() {
        timeRemaining = 100
        appIsActive = true
        loadData()
    }
}

#Preview {
    ContentView()
}
