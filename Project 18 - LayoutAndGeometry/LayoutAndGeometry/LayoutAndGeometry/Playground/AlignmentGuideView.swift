//
//  AlignmentGuideView.swift
//  LayoutAndGeometry
//
//  Created by Mauro Grillo on 11/01/2024.
//

import SwiftUI

struct AlignmentGuideView: View {
    var body: some View {
        VStack {
            Text("Live long and prosper!")
                .frame(width: 300, height: 40, alignment: .topLeading)

            HStack(alignment: .bottom) { // bottom of the text of the text will be placed at the bottom of the hstack
                Text("Live")
                    .font(.caption)
                Text("Long")
                Text("and")
                    .font(.title)
                Text("prosper")
                    .font(.largeTitle)
            }

            HStack(alignment: .lastTextBaseline) {
                Text("Live")
                    .font(.caption)
                Text("Long")
                Text("and")
                    .font(.title)
                Text("prosper")
                    .font(.largeTitle)
            }
            
            // The original leading position (VStack leading) is at x = 0, y = 0. This position doesn't change, what changes is the position of the view with respect to that position. In this case, the Text 'Hello, world!' its 'leading' position is assigned so that it is shifted 50 points to the left of the VStack leading, this does not affect the leading of the following Text, which is still at x = 0. (See 'HorizontalAlignment' image)
            VStack(alignment: .leading) {
                Text("Hello, world!")
                    .alignmentGuide(.leading) { _ in
                        50
                    }
                Text("This is a longer line of text")
            }
            .background(.red)
            .frame(width: 300, height: 100)
            .background(.blue)

            VStack(alignment: .leading) {
                Text("Hello, world!")
                    .alignmentGuide(.leading) { dimension in
                        dimension[.trailing]
                        // Here we are telling that the 'trailing' of the Text needs to be at x=0 (the original leading position of the VStack)
                    }
                Text("This is a longer line of text")
            }
            .background(.red)
            .frame(width: 300, height: 100)
            .background(.blue)

            VStack(alignment: .leading) {
                ForEach(0..<5) { position in
                    Text("Number \(position)")
                        .alignmentGuide(.leading) { _ in
                            Double(position) * -10
                        }
                }
            }
            .background(.red)
            .frame(width: 300, height: 200)
            .background(.blue)
        }

        ZStack(alignment: .center) {
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundStyle(.red)
            Rectangle()
                .frame(width: 50, height: 75)
                .foregroundStyle(.blue)
                .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in
                    75
                })
                .alignmentGuide(VerticalAlignment.center, computeValue: { _ in
                    75
                })
            // Because is a ZStack we need to override the two center guides (Horizontal and Vertical)
            // Alignment guides are now 75 in both directions
        }
    }
}

#Preview {
    AlignmentGuideView()
}
