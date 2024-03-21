//
//  ContextMenuPlayground.swift
//  HotPorspects
//
//  Created by Mauro Grillo on 02/01/2024.
//

import SwiftUI
// Context menus are hidden parts of the UI, so we shouldn't include any important UI options here.
struct ContextMenuPlayground: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .background(backgroundColor)

            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(role: .destructive) {
                        backgroundColor = .red
                    } label: {
                        Label("Red", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.red)
                        // The foreground color is ignored, if we want it to be red, we must use 'role: .destructive'
                    }

                    Button("Green") {
                        backgroundColor = .green
                    }

                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

#Preview {
    ContextMenuPlayground()
}
