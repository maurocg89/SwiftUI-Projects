//
//  ChallengeContentView.swift
//  LayoutAndGeometry
//
//  Created by Mauro Grillo on 15/01/2024.
//

import SwiftUI

struct ChallengeContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

        var body: some View {
            GeometryReader { fullView in
                ScrollView(.vertical) {
                    ForEach(0..<25) { index in
                        GeometryReader { geo in
                            // For Debug
                            let maxY = geo.frame(in: .global).maxY
                            let minY = geo.frame(in: .global).minY
                            let fullSizeHeight = fullView.size.height
                            let opacityHeight = fullView.frame(in: .global).minY + 200
                            let opacityValue = maxY <= opacityHeight ? Double(abs((opacityHeight - maxY - 200) * 0.001)) : 1
                            let scaleEffectValue = max((minY - fullSizeHeight / 14) / (fullView.size.height / 2), 0.5)

                            let _ = debugPrint("Index: \(index), Geo MAXY: \(maxY), Geo MINY: \(minY), FullView MAXY: \(fullView.frame(in: .global).maxY), FullView MINY: \(fullView.frame(in: .global).minY), FullView Height: \(fullSizeHeight), OpacityHEIGHT: \(opacityHeight), Opacity: \(geo.frame(in: .global).minY / 200), OpacityValue: \(opacityValue), SCALE: \(scaleEffectValue)")

                            Text("Row #\(index)")
                                .font(.title)
                                .frame(maxWidth: .infinity)
                                .background(colors[index % 7]
                                    .opacity(geo.frame(in: .global).minY / 200))
                                .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                                .scaleEffect(scaleEffectValue)
                        }
                        .frame(height: 40)
                    }
                }
            }
        }
}

#Preview {
    ChallengeContentView()
}
