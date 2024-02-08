//
//  ContentUnavailablePlayground.swift
//  Instafilter
//
//  Created by Mauro Grillo on 08/02/2024.
//

import SwiftUI

struct ContentUnavailablePlayground: View {
    var body: some View {
        if #available(iOS 17.0, *) {
            ContentUnavailableView {
                Label("No snippets", systemImage: "swift")
            } description: {
                Text("You don't have any saved snippets yet")
            } actions: {
                Button("Create snippet") {}
                    .buttonStyle(.borderedProminent)
            }
        } else {
            Text("Hello world!")
        }
    }
}

#Preview {
    ContentUnavailablePlayground()
}
