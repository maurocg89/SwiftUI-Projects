//
//  NavigationLinkPlayground.swift
//  MoonshotLegacy
//
//  Created by Mauro Grillo on 24/02/2024.
//

import SwiftUI

struct NavigationLinkPlayground: View {
    var body: some View {
        NavigationView {
            List(0..<100) { row in
                NavigationLink {
                    Text("Detail \(row)")
                } label: {
                    Text("Row \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

#Preview {
    NavigationLinkPlayground()
}
