//
//  ContentViewSD.swift
//  HotPorspects
//
//  Created by Mauro Grillo on 14/02/2024.
//

import SwiftUI

struct ContentViewSD: View {
    var body: some View {
        TabView {
            ProspectsViewSD(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
                .tag("Everyone")

            ProspectsViewSD(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
                .tag("Contacted")

            ProspectsViewSD(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
                .tag("Uncontacted")

            MeViewSD()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    ContentViewSD()
}
