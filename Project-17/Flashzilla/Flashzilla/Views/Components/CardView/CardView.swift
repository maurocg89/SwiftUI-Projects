//
//  CardView.swift
//  Flashzilla
//
//  Created by Mauro Grillo on 05/01/2024.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil

    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)

            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundStyle(.gray)
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50))) // Fade away based on the offset
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset.width = gesture.translation.width / 2
                }
                .onEnded { _ in
                    // We use abs to work with left and right dragging
                    if abs(offset.width) > 100 {
                        // Remove the card when we move it far enough
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
    }
}

#Preview {
    CardView(card: Card.example)
}
