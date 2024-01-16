//
//  ColorsAndFramePlayground.swift
//  GuessTheFlag
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct ColorsAndFramePlayground: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }
//            Color.blue
//                .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)
//            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                .background(.red)
            Text("Content")
                .foregroundStyle(.secondary)
//                .foregroundColor(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}

struct ColorsAndFramePlayground_Previews: PreviewProvider {
    static var previews: some View {
        ColorsAndFramePlayground()
    }
}
