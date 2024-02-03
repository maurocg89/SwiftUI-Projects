//
//  CustomizationPlayground.swift
//  Navigation
//
//  Created by Mauro Grillo on 03/02/2024.
//

import SwiftUI

// MARK: Customizing the navigation bar appearance
struct CustomizationPlayground: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                Text("Row \(i)")
            }
            .navigationTitle("Title goes here")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue, for: .navigationBar)
            .toolbarColorScheme(.dark)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
// MARK: Placing toolbar buttons in exact locations
struct PlacingToolbarButtons: View {
    var body: some View {
        NavigationStack {
            Text("Hello World!")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Tap me") {}
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Or Tap me") {}
                    }
                    // Same result as using two ToolbarItems
                    ToolbarItemGroup(placement: .confirmationAction) {
                        Button("Tap me") {}
                        Button("Or me") {}
                    }
                }
                .navigationBarBackButtonHidden()
        }
    }
}

// MARK: Making your navigation title editable
struct NavigationTitleEditable: View {
    @State private var title = "SwiftUI"

    var body: some View {
        NavigationStack {
            Text("Hello World!")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationTitleEditable()
}
