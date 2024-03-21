//
//  SearcheableView.swift
//  SnowSeeker
//
//  Created by Mauro Grillo on 23/01/2024.
//

import SwiftUI
// Making a SwiftUI view searchable

struct SearchableView: View {
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stephanie"]

    var body: some View {
        // It is important to add a searcheable modifier inside a NavigationStack/NavigationView so iOS has a place to put the search bar
        NavigationStack {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }

    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        }
        return allNames.filter{ $0.localizedCaseInsensitiveContains(searchText) }
    }
}

#Preview {
    SearchableView()
}
