//
//  ScoreView.swift
//  Flashzilla
//
//  Created by Mauro Grillo on 10/01/2024.
//

import SwiftUI

struct SummaryView: View {
    let totalCards: Int
    let correctAnswers: Int
    let incorrectAnswers: Int
    let buttonAction: (() -> Void)?

    var body: some View {
        VStack {
            Text("Summary")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()

            HStack {
                Text("Total cards:")
                    .font(.title2)
                    .foregroundStyle(.white)

                Text("\(totalCards)")
                    .font(.title2)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.horizontal)

            HStack {
                Text("Correct answers:")
                    .font(.title2)
                    .foregroundStyle(.white)

                Text("\(correctAnswers)")
                    .font(.title2)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.horizontal)

            HStack {
                Text("Incorrect answers:")
                    .font(.title2)
                    .foregroundStyle(.white)

                Text("\(incorrectAnswers)")
                    .font(.title2)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.horizontal)
            
            Button("Start Again") {
                buttonAction?()
            }
            .padding()
            .background(.white)
            .foregroundStyle(.black)
            .clipShape(.capsule)
            .padding()

            Spacer()
        }
        .frame(width: 450, height: 250)
        .background(.black.opacity(0.75))
        .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
    }
}

#Preview {
    SummaryView(totalCards: 14, correctAnswers: 14, incorrectAnswers: 4, buttonAction: {})
}
