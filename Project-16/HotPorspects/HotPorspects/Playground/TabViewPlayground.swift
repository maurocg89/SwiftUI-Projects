//
//  TabViewPlayground.swift
//  HotPorspects
//
//  Created by Mauro Grillo on 02/01/2024.
//

import SwiftUI

struct TabViewPlayground: View {
    @State private var selectedTab = "One"

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    selectedTab = "Two"
                }
                .tabItem {
                    Label("One", systemImage: "star")
                }

            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
}

#Preview {
    TabViewPlayground()
}
