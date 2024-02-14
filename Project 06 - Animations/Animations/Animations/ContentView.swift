//
//  ContentView.swift
//  Animations
//
//  Created by Mauro Grillo on 23/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            ImplicitAnimations()
            BindingAnimations()
            ExplicitAnimations()
            GestureAnimations()
            ShowHideView()
            CustomTransitionView()
            Spacer()
        }
        .padding()
    }
}


// MARK: Implicit Animations
struct ImplicitAnimations: View {
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
        //            .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
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

// MARK: Binding Animations
struct BindingAnimations: View {
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

// MARK: Explicit Animations
struct ExplicitAnimations: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Explicit Animation") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 2)) {
                animationAmount += 360
            }
        }
        .padding(70)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

// MARK: Gestures Animation
struct GestureAnimations: View {
//    @State private var dragAmount = CGSize.zero
    let letters = Array("Hello, SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.default.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
    
//    var body: some View {
//        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 200)
//            .clipShape(.rect(cornerRadius: 10))
//            .offset(dragAmount)
//            .gesture(
//                DragGesture()
//                    .onChanged { dragAmount = $0.translation }
//                    .onEnded { _ in
//                        withAnimation {
//                             dragAmount = .zero
//                        }
//                    }
//            )
//            .animation(.spring(), value: dragAmount)
//    }
}

// MARK: Showing And Hiding View
struct ShowHideView: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap Me (Show Hide)") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

// MARK: Custom Transitions using ViewModifiers
struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct CustomTransitionView: View {
    @State private var isShowingRed = false
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
