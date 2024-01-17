//
//  ContentView.swift
//  DiceRoller
//
//  Created by Mauro Grillo on 16/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var dicesAmount = 5
    @State private var diceValue = 1
    @State private var diceValues = [Int]()
    @State private var showingSheet = false
    @State private var isGameStarted = false
    @State private var score = 0

    let itemsPerRow = 2
    private var numberOfRows: Int {
        return (dicesAmount + itemsPerRow - 1) / itemsPerRow
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            settingsButton

            VStack {

                Text("Score: \(score)")
                    .font(.largeTitle)

                dicesGridView

                Button("Roll") {
                    rollDices()
                }
                .padding()
                .background(.white)
                .foregroundStyle(.black)
                .clipShape(.capsule)
                .padding()
            } // VStack
        } // ZStack
        .onAppear {
            initialSettings()
        }
    }

    private func initialSettings() {
        diceValues = Array.init(repeating: 1, count: dicesAmount)
    }

    private func rollDices() {
        for index in diceValues.indices {
            for i in stride(from: 1.0, to: 0, by: -0.2) {
                DispatchQueue.main.asyncAfter(deadline: .now() + i) {
                    diceValues[index] = .random(in: 1...6)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                score = diceValues.reduce(0, +)
            }
        }
    }

    private var settingsButton: some View {
        VStack {
            HStack {
                Button {
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
                                if index < dicesAmount {
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
}

#Preview {
    ContentView()
}
