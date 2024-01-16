//
//  AbsolutePositioningView.swift
//  LayoutAndGeometry
//
//  Created by Mauro Grillo on 12/01/2024.
//

import SwiftUI

struct AbsolutePositioningView: View {
    var body: some View {
        Text("Hello, World!")
            .background(.blue)
            .position(x: 100, y: 100) 
        // Absolute position
        // When we use position like this, we'll get back a new view that takes up all available space. It does that so that it can position its child correctly.
            .background(.red)
    }
}

struct RelativePositioningView: View {
    var body: some View {
        Text("Hello, World!")
            .background(.blue)
            .offset(x: 100, y: 100)
        // Relative position
        // When we use the offset modifier like this, we're changing the location where a view should be rendered without changing its underlaying dimensions (x, y, width and height), we're just saying render it somewhere else the position hasn't changed.
            .background(.red)
        // We're using the original position of the Text, the offset doesn't affect the background here at all
    }
}

#Preview {
//    AbsolutePositioningView()
    RelativePositioningView()
}
