//
//  TextEditorPlaygroundView.swift
//  Bookworm
//
//  Created by Mauro Grillo on 06/07/2023.
//

import SwiftUI

struct TextEditorPlayground: View {
    @AppStorage("notes") private var notes = ""

    var body: some View {
        NavigationStack {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

#Preview {
    TextEditorPlayground()
}
