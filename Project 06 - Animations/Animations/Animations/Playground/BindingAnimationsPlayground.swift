//
//  BindingAnimationsPlayground.swift
//  Animations
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct BindingAnimationsPlayground: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                    .repeatCount(3)
            ), in: 1...10)
            .padding(.bottom, 10)
            Button("Binding Animation") {
                animationAmount += 1
            }
            .padding(70)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
        }
    }
}

struct BindingAnimationsPlayground_Previews: PreviewProvider {
    static var previews: some View {
        BindingAnimationsPlayground()
    }
}
