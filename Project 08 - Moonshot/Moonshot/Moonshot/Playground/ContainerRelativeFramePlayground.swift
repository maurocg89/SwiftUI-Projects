//
//  ContainerRelativeFramePlayground.swift
//  Moonshot
//
//  Created by Mauro Grillo on 15/02/2024.
//

import SwiftUI

struct ContainerRelativeFramePlayground: View {
    var body: some View {
        Image(.example)
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) { size, axis in
                // Here axis is horizontal
                // The size value is the actual measured size of the parent view, in our case, the full screen width
                size * 0.8
            }
    }
}

#Preview {
    return ContainerRelativeFramePlayground()
}
