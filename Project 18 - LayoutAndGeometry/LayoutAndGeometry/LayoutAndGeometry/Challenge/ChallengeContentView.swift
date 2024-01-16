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
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            // For Debug
                            let maxY = geo.frame(in: .global).maxY
                            let minY = geo.frame(in: .global).minY
                            let fullSizeHeight = fullView.size.height
                            let opacityHeight = fullView.frame(in: .global).minY + 200
                            let opacityValue2 = maxY <= opacityHeight ? Double(abs((opacityHeight - maxY - 200) * 0.001)) : 1

                            let rotationEffectValue = minY - fullSizeHeight / 2
                            let opacityValue = minY / 200
                            let scaleEffectValue = max((minY - fullSizeHeight / 14) / (fullView.size.height / 2), 0.5)
                            let colorHueGenerator = min((minY - fullSizeHeight / 14) / fullSizeHeight, 1.0)

                            let _ = debugPrint("Index: \(index), Geo MAXY: \(maxY), Geo MINY: \(minY), FullView MAXY: \(fullView.frame(in: .global).maxY), FullView MINY: \(fullView.frame(in: .global).minY), FullView Height: \(fullSizeHeight), OpacityHEIGHT: \(opacityHeight), Opacity: \(geo.frame(in: .global).minY / 200), OpacityValue: \(opacityValue2), SCALE: \(scaleEffectValue), Color: \(colorHueGenerator)")

                            Text("Row #\(index)")
                                .font(.title)
                                .frame(maxWidth: .infinity)
                                .background(Color(hue: colorHueGenerator, saturation: 1, brightness: 1)
                                    .opacity(opacityValue))
                                .rotation3DEffect(.degrees(rotationEffectValue) / 5, axis: (x: 0, y: 1, z: 0))
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
