//
//  ContentView.swift
//  DiceRoller
//
//  Created by Mauro Grillo on 16/01/2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var dicesAmount = 1
    @State private var diceValues = [Int]()
    @State private var showingSheet = false
    @State private var isRollingDice = false
    @State private var shakingCounter = 2.0
    @State private var feedback = UINotificationFeedbackGenerator()

    @State private var score = 0
    @State private var saveScores = true
    @State private var savedScores = [Score]()
    @State private var showSavedScoresModal = false
    @State private var numberOfScoresToShow = 1

    var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    let shakingTime = 2.0
    let itemsPerRow = 2
    
    private var numberOfRows: Int {
        return (dicesAmount + itemsPerRow - 1) / itemsPerRow
    }

    private var scoresToShow: [Score] {
        guard !savedScores.isEmpty else { return [] }
        if numberOfScoresToShow > savedScores.count {
            return savedScores
        }
        return Array(savedScores.prefix(upTo: numberOfScoresToShow))
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            if showSavedScoresModal {
                SavedScoresModalView(savedScores: scoresToShow)
                    .zIndex(1)
            }

            settingsButton

            latestScoresButton

            VStack {

                Text("Score: \(score)")
                    .font(.largeTitle)

                dicesGridView

                Button("Roll") {
//                    rollDices()
                    simpleHaptic(type: .success)
                    isRollingDice = true
                }
                .padding()
                .background(.white)
                .foregroundStyle(.black)
                .clipShape(.capsule)
                .padding()
                .allowsHitTesting(!isRollingDice)
            } // VStack
        } // ZStack
        .onTapGesture {
            showSavedScoresModal = false
        }
        .onAppear {
            initialSettings()
            loadScores()
        }
        .onReceive(timer) { time in
            guard isRollingDice else { return }
            
            if shakingCounter > 0 {
                diceValues = diceValues.map { _ in
                        Int.random(in: 1...6)
                }
                shakingCounter -= 0.2
                return
            }

            isRollingDice = false
            shakingCounter = shakingTime
            calculateScore()
        }
        .sheet(isPresented: $showingSheet) {
            SettingsView(saveScores: $saveScores, dicesAmount: $dicesAmount, totalSavedScores: $numberOfScoresToShow) {
                initialSettings()
            }
        }
    }

    // MARK: Private Functions
    private func initialSettings() {
        score = 0
        let totalScores = UserDefaults().integer(forKey: Score.totalScoresKey)
        numberOfScoresToShow = totalScores == 0 ? 1 : totalScores

        let dicesFromUserDefaults = UserDefaults().integer(forKey: Score.dicesAmountKey)
        dicesAmount = dicesFromUserDefaults == 0 ? 1 : dicesFromUserDefaults

        diceValues = Array.init(repeating: 1, count: dicesAmount)
        feedback.prepare()
    }

    // Using DispatchQueue instead of Timer
//    private func rollDices() {
//        for index in diceValues.indices {
//            for i in stride(from: 1.0, to: 0, by: -0.2) {
//                DispatchQueue.main.asyncAfter(deadline: .now() + i) {
//                    diceValues[index] = .random(in: 1...6)
//                }
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
//                score = diceValues.reduce(0, +)
//                isRollingDice = false
//            }
//        }
//    }

    private func calculateScore() {
        score = diceValues.reduce(0, +)
        saveScore(Score(id: UUID(), score: score, amountOfDices: dicesAmount))
    }

    private func simpleHaptic(type: UINotificationFeedbackGenerator.FeedbackType) {
        feedback.notificationOccurred(type)
    }

    private func loadScores() {
        savedScores = FileManager().getData(Score.savedFileName) ?? []
    }

    private func saveScore(_ score: Score) {
        if savedScores.count == Score.maximumCapacity {
            savedScores.removeLast()
        }
        savedScores.insert(score, at: 0)
        FileManager().saveData(Score.savedFileName, savedScores)
    }

    // MARK: Computed Properties Views

    private var settingsButton: some View {
        VStack {
            HStack {
                Button {
                    showSavedScoresModal = false
                    showingSheet = true
                } label: {
                    Image(systemName: "gear")
                        .padding()
                        .background(.black.opacity(0.7))
                        .clipShape(.circle)
                }
                Spacer()
            } // HStack
            Spacer()
        } // VStack
        .foregroundStyle(.white)
        .font(.largeTitle)
        .padding()
    }

    private var latestScoresButton: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    showSavedScoresModal.toggle()
                } label: {
                    Image(systemName: "list.bullet")
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

    private var dicesGridView: some View {
        Group {
            if diceValues.isEmpty {
                EmptyView()
            } else {
                VStack(spacing: 10) {
                    ForEach(0..<numberOfRows, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<self.itemsPerRow, id: \.self) { column in
                                let index = row * self.itemsPerRow + column
                                if index < diceValues.count {
                                    DiceView(numberOfDots: $diceValues[index])
                                }
                            } // ForEach
                        } // HStack
                    } // ForEach
                } // VStack
            }
        }
        .padding()
    }

    // Using Grid
    //    private var dicesGridView: some View {
    //        Grid(alignment: .center, horizontalSpacing: 20, verticalSpacing: 20) {
    //            ForEach(0..<numberOfRows, id: \.self) { row in
    //                GridRow {
    //                    ForEach(0..<itemsPerRow, id: \.self) { column in
    //                        let index = row * self.itemsPerRow + column
    //                        if index < dicesAmount {
    //                            DiceView(numberOfDots: $diceValue)
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
}

#Preview {
    ContentView()
}
