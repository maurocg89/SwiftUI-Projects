//
//  InsettableShapePlayground.swift
//  Drawing
//
//  Created by Mauro Grillo on 30/05/2023.
//

import SwiftUI

struct InsettableShapePlayground: View {
    var body: some View {
//        Circle()
//            .strokeBorder(.blue, lineWidth: 40)
        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            .strokeBorder(.blue, lineWidth: 40)
    }
}

struct InsettableShapePlayground_Previews: PreviewProvider {
    static var previews: some View {
        InsettableShapePlayground()
    }
}
