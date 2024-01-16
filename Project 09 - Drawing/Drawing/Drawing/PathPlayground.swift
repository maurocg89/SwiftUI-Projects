//
//  PathPlayground.swift
//  Drawing
//
//  Created by Mauro Grillo on 30/05/2023.
//

import SwiftUI

struct PathPlayground: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
//            path.closeSubpath()
        }
//        .stroke(.blue, lineWidth: 10)
        .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
    }
}

struct PathPlayground_Previews: PreviewProvider {
    static var previews: some View {
        PathPlayground()
    }
}
