//
//  ScrollViewEffectsWithGR.swift
//  LayoutAndGeometry
//
//  Created by Mauro Grillo on 12/01/2024.
//

import SwiftUI

struct ScrollViewEffectsWithGR: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .green, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullViewGeo in // Reads all available screen space
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader { geo in // Reads the current screen space for this internal single height 40 row view
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullViewGeo.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct ScrollViewEffectsHorizontal: View {

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    GeometryReader { geo in
                        Text("Number \(num)")
                            .font(.title)
                            .padding()
                            .background(.red)
                        // minX to get the left edge of the screen and then divide it by 8 to spin more gently
                            .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
    }
}

#Preview {
//    ScrollViewEffectsWithGR()
    ScrollViewEffectsHorizontal()
}
