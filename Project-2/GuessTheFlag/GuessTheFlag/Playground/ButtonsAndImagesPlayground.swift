//
//  ButtonsAndImagesPlayground.swift
//  GuessTheFlag
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct ButtonsAndImagesPlayground: View {
    var body: some View {
        VStack(spacing: 10) {
            Button("Button 1") { }
                .buttonStyle(.bordered)
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)
            Button {
                print("Button was tapped")
            } label: {
                Text("Tap me!")
                    .padding()
                    .foregroundColor(.white)
                    .background(.red)
            }
            Button {
                print("Edit button was tapped")
            } label: {
                Image(systemName: "pencil")
                    .renderingMode(.original)
            }
            Button {
                print("Edit button was tapped")
            } label: {
                Label("Edit", systemImage: "pencil")
            }
        }
    }
}

struct ButtonsAndImagesPlayground_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsAndImagesPlayground()
    }
}
