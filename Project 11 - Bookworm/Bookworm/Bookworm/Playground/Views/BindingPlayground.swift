//
//  BindingPlayground.swift
//  Bookworm
//
//  Created by Mauro Grillo on 05/07/2023.
//

import SwiftUI

struct BindingPlayground: View {
    @State private var rememberMe = false

    var body: some View {
        VStack {
            PushButton(title: "Remember", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(
            LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom)
        )
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
}

#Preview {
    BindingPlayground()
}
