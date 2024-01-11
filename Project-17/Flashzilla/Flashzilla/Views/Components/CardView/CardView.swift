//
//  CardView.swift
//  Flashzilla
//
//  Created by Mauro Grillo on 05/01/2024.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled

    let card: Card
    var retryIncorrectCards = false
    var removal: ((_ correctAnswer: Bool) -> Void)? = nil

    @State private var feedback = UINotificationFeedbackGenerator()
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(getBackgroundColor(offset: offset))
                )
                .shadow(radius: 10)

            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)

                    Text(isShowingAnswer ? card.answer : "Tap to see the answer")
                        .font(.title2)
                        .foregroundStyle(.gray)
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        } // ZStack
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50))) // Fade away based on the offset
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset.width = gesture.translation.width / 2
                    feedback.prepare()
                }
                .onEnded { _ in
                    // We use abs to work with left and right dragging
                    if abs(offset.width) > 100 {
                        if offset.width < 0 {
                            feedback.notificationOccurred(.error)
                            removal?(false)
                            if retryIncorrectCards {
                                offset = .zero
                            }
                            return
                        }
                        // Remove the card when we move it far enough
                        removal?(true)
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
    
    // Challenge 2: Fix a bug when the user drags a card to the right but not far enough to remove it and release it, the card turn red as it slides back to the center.
    private func getBackgroundColor(offset: CGSize) -> Color {
        if offset.width > 0 {
            return .green
        } else if offset.width < 0 {
            return .red
        }
        return .white
    }
}

#Preview {
    CardView(card: Card.example)
}
