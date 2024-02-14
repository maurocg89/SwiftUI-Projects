//
//  ImplicitAnimationsPlayground.swift
//  Animations
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct ImplicitAnimationsPlayground: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        Button("Implicit Animation") {
            //                animationAmount += 1
            //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            //                    animationAmount -= 1
            //                }
        }
        .padding(70)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .overlay(content: {
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        })
        //            .scaleEffect(animationAmount)
        //            .blur(radius: (animationAmount - 1) * 3)
        //            .animation(.default, value: animationAmount)
        //            .animation(.easeOut, value: animationAmount)
        //            .animation(.spring(duration: 1, bounce: 0.6), value: animationAmount)
        //            .animation(
        //                .easeInOut(duration: 1)
        //                    .delay(0.2),
        //                value: animationAmount
        //            )
        //            .animation(
        //                .easeInOut(duration: 1)
        //                    .repeatCount(3, autoreverses: true),
        //                value: animationAmount
        //            )
        .onAppear {
            animationAmount = 2
        }
    }
}

struct ImplicitAnimationsPlayground_Previews: PreviewProvider {
    static var previews: some View {
        ImplicitAnimationsPlayground()
    }
}
