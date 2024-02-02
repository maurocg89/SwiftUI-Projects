//
//  DrawingGroupPlayground.swift
//  Drawing
//
//  Created by Mauro Grillo on 30/05/2023.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom),
                        lineWidth: 2)
//                        color(for: value, brightness: 1), lineWidth: 2)
            }
        }
        .drawingGroup() // To use Metal framework (high performance gpu) instead of CoreAnimation
        // This tell swiftui it should render the contents of the view into an off-screen image before putting back onto the screen as a single piece of rendered output wich is significantly faster
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
    
}

struct DrawingGroupPlayground: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
                .padding(.horizontal)
        }
    }
}

struct DrawingGroupPlayground_Previews: PreviewProvider {
    static var previews: some View {
        DrawingGroupPlayground()
    }
}
