//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Mauro Grillo on 11/01/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            List {
                NavigationLink(destination: LayoutView()) {
                    Text("How layouts work in SwiftUI")
                }
                NavigationLink(destination: AlignmentGuideView()) {
                    Text("Alignment and alignment guides")
                }
                NavigationLink(destination: CustomAlignmentGuide()) {
                    Text("Custom alignment guide")
                }
                NavigationLink(destination: AbsolutePositioningView()) {
                    Text("Absolute positioning")
                }
                NavigationLink(destination: GeometryReaderDisplay()) {
                    Text("GeometryReader")
                }
                NavigationLink(destination: ScrollViewEffectsWithGR()) {
                    Text("ScrollView effects using GeometryReader")
                }
            }
            .listStyle(.inset)
            .padding()
            .navigationTitle("Layout And Geometry")
        }
    }
}

#Preview {
    ContentView()
}
