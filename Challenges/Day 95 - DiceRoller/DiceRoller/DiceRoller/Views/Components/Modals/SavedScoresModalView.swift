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

                            Label("\(score.score)", systemImage: "dice.fill")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Spacer()
                    } // ScrollView
                    .scrollIndicators(.hidden)
                } // VStack

            } // ZStack
            .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.6)
            .frame(width: geo.size.width, height: geo.size.height)

        } // GeometryReader

    }
}

#Preview {
    SavedScoresModalView(savedScores: Score.examples)
}
