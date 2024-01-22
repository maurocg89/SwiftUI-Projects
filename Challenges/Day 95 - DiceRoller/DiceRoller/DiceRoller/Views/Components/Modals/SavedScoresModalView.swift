//
//  SavedScoresView.swift
//  DiceRoller
//
//  Created by Mauro Grillo on 19/01/2024.
//

import SwiftUI

struct SavedScoresModalView: View {
    let savedScores: [Score]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundStyle(.black.opacity(0.8))
                VStack(alignment: .center) {
                    Text("Latest Scores:")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding()
                    ScrollView {
                        ForEach(Array(savedScores.enumerated()), id: \.element.id) { index, score in
                            HStack {
                                ForEach(0..<score.amountOfDices, id: \.self) { dice in
                                    Image(systemName: "dice.fill")
                                        .resizable()
                                        .foregroundStyle(.white)
                                        .frame(width: 14, height: 14)
                                }
                                Text("\(score.score)")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                    .padding(.leading, 4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        Spacer()
                    } // ScrollView
                    .scrollIndicators(.hidden)
                }
                // VStack
                .padding(.leading)

            } // ZStack
            .frame(width: geo.size.width * 0.85, height: geo.size.height * 0.65)
            .frame(width: geo.size.width, height: geo.size.height)

        } // GeometryReader

    }
}

#Preview {
    SavedScoresModalView(savedScores: Score.examples)
}
