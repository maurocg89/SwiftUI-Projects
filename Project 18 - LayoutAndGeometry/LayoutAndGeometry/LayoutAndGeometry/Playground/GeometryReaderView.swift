//
//  GeometryReaderView.swift
//  LayoutAndGeometry
//
//  Created by Mauro Grillo on 12/01/2024.
//

import SwiftUI
// GeometryReader allows us to read the size proposed by the parent and use that to manipulate our view however we want to
struct GeometryReaderView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in // geometry proxy, it contains the parents proposed size, how much space we can have plus any safe area ubsets we want to read and also a method for reading frame values.
                Text("Hello, World!")
                    .frame(width: geo.size.width * 0.9)
                    .background(.red)
            }
            .background(.green)

            Text("More text")
                .background(.blue)
        }
    }
}

struct GeometryReaderDisplay: View {
    var body: some View {
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)") // Center of GeometryReaderDisplay with safe area

                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)") // Center of InnerView

                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)") // Center of coordinateSpace defined in OuterView without safe area
                    }
            }
            .background(.orange)

            Text("Right")
        }
    }
}

#Preview {
    GeometryReaderView()
}
