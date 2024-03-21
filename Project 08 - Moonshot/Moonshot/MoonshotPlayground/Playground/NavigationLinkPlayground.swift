//
//  NavigationLinkPlayground.swift
//  Moonshot
//
//  Created by Mauro Grillo on 19/05/2023.
//

import SwiftUI

struct NavigationLinkPlayground: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { row in
//                NavigationLink {
//                    Text("Detail \(row)")
//                } label: {
//                    Text("Row \(row)")
//                }
                NavigationLink("Row \(row)", value: row)
            }
            .navigationDestination(for: Int.self, destination: { value in
                Text("Detail \(value)")
            })
            .navigationTitle("SwiftUI")
        }
    }
}

#Preview {
    NavigationLinkPlayground()
}
