//
//  GesturesPlayground.swift
//  Flashzilla
//
//  Created by Mauro Grillo on 04/01/2024.
//

import SwiftUI

struct GesturesPlayground: View {
    @State private var text = "Hello, OnTap!"
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    @State private var currentAngleAmount = Angle.zero
    @State private var finalAngleAmount = Angle.zero
    @State private var offset = CGSize.zero
    @State private var isDragging = false


    var body: some View {
        VStack {
            Text(text)
                .onTapGesture(count: 2) {
                    text = "Double tapped!"
                    print("Double tapped!")
                }
                .onLongPressGesture(minimumDuration: 1) {
                    text = "Long pressed!"
                } onPressingChanged: { inProgress in
                    text = "In progress: \(inProgress)"
                }
                .padding()
        }
        // The child has priority unless we use 'highPriorityGesture'
//        .onTapGesture(count: 2) {
//            text = "VStack Double Tap"
//        }
//        .highPriorityGesture(
//            TapGesture(count: 2)
//                .onEnded {
//                text = "VStack Double Tap High Priority"
//            }
//        )
        // Both gestures triggers at the same time (Text and VStack)
        .simultaneousGesture(
            TapGesture(count: 2)
                .onEnded {
                text = "VStack Double Tap Simultaneous"

                    print("VStack Double Tap Simultaneous")
            }
        )

        Text("Hello, Scale Effect!")
            .scaleEffect(finalAmount + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { amount in
                        currentAmount = amount - 1
                    }
                    .onEnded { amount in
                        finalAmount += currentAmount
                        currentAmount = 0
                    }
            )
            .padding()

        Text("Hello, Rotation Effect!")
            .rotationEffect(currentAngleAmount + finalAngleAmount)
            .gesture(
                RotationGesture()
                    .onChanged { angle in
                        currentAngleAmount = angle
                    }
                    .onEnded { angle in
                        finalAngleAmount += currentAngleAmount
                        currentAngleAmount = .zero
                    }
            )
            .padding()

        // Gesture Sequence
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }

        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        let combined = pressGesture.sequenced(before: dragGesture)

        Text("Hello, Gesture Sequence!")
            .scaleEffect(isDragging ? 1.5 : 1.0)
            .offset(offset)
            .gesture(combined)
            .padding()

    }
}

#Preview {
    GesturesPlayground()
}
