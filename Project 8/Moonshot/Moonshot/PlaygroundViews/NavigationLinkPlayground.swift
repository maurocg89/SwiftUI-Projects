//
//  NavigationLinkPlayground.swift
//  Moonshot
//
//  Created by Mauro Grillo on 19/05/2023.
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

struct NavigationLinkPlayground_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkPlayground()
    }
}
