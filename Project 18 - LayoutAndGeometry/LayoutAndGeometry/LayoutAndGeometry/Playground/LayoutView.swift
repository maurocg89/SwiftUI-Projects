//
//  LayoutView.swift
//  LayoutAndGeometry
//
//  Created by Mauro Grillo on 11/01/2024.
//

import SwiftUI

// All SwiftUI layout take place in 3 steps:
// 1. A parent view proposes a size for its child
// 2. Based on that proposal the child then chooses its own size and the parent must respect that choice
// 3. The parent then positions the child in its coordinate space somehow


// ContentView here is layout neutral (does not have any size of its own, adjusts to fit whatever size actually needed)
// 1. SwiftUI ask to ContentView how much space it needs, because ContentView is layout neutral, it ask 'background' (child) how much space it needs.
// 3. After receiving how much space from ContentView, SwiftUI decide to position it in the center of the screen
struct LayoutView: View {
    var body: some View {
        VStack {
            // 2. Text says that he need the space of 'Hello, world' in a default font
            Text("Hello, world!")
                .background(.red)
            // 1. Background is also layout neutral so it ask 'Text' (child) how much space it needs

            // Here in the step 2 when padding ask 'Text' how much space it needs, also reserve 20 points on each side
            Text("Hello")
                .padding(20)
                .background(.red)
        }
        .padding()
    }
}

struct LayoutNeutralView: View {
    var body: some View {
        // Here Color.red is layout neutral and it has no child, so it takes all the space available
        Color.red
    }
}

#Preview {
    LayoutView()
}
