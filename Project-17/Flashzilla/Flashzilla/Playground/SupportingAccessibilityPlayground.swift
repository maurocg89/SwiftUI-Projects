//
//  SupportingAccessibilityPlayground.swift
//  Flashzilla
//
//  Created by Mauro Grillo on 05/01/2024.
//

import SwiftUI

// We use rethrows here to avoid handling errors (do, try, catch) when passing as a 'body' parameter a function that doesn't have 'throws' in its definition.
// Full explanation: https://www.hackingwithswift.com/example-code/language/how-to-use-the-rethrows-keyword
func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct SupportingAccessibilityPlayground: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    @State private var scale = 1.0

    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }

            Text("Sucess")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundStyle(.white)
        .clipShape(.capsule)

        Divider()

        Text("Hello, Reduce Motion!")
            .padding()
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation {
                    scale *= 1.5
                }
            }

        Divider()

        Text("Hello, Reduce Transparency!")
            .scaleEffect(scale)
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundStyle(.white)
            .clipShape(.capsule)

    }
}

#Preview {
    SupportingAccessibilityPlayground()
}
