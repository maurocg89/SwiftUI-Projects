//
//  ExplicitAnimationsPlayground.swift
//  Animations
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct ExplicitAnimationsPlayground: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Explicit Animation") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 2)) {
                animationAmount += 360
            }
        }
        .padding(70)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct ExplicitAnimationsPlayground_Previews: PreviewProvider {
    static var previews: some View {
        ExplicitAnimationsPlayground()
    }
}
