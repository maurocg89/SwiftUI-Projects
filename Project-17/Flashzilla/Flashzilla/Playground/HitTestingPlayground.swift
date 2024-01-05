//
//  HitTestingPlayground.swift
//  Flashzilla
//
//  Created by Mauro Grillo on 05/01/2024.
//

import SwiftUI

struct HitTestingPlayground: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Rectangle tapped!")
                    }

                Circle()
                    .fill(.red)
                    .frame(width: 300, height: 300)
                    .contentShape(Rectangle()) // All frame will be use as a tap area. Useful for stacks with Spacer (example below)
                    .onTapGesture {
                        print("Circle tapped!")
                    }
                    .allowsHitTesting(false) // Ignore the tap area
            }

            VStack {
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                print("VStack tapped!")
            }
        }

    }
}

#Preview {
    HitTestingPlayground()
}
