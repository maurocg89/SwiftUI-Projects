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
        NavigationView {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct TextEditorPlayground_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorPlayground()
    }
}
