//
//  GridLayoutView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 15/10/2023.
//

import SwiftUI

struct GridLayout: View {
    let people: [Person]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(people) { person in
                    NavigationLink {
                        PersonDetailView(person: person)
                    } label: {
                        PersonCardView(person: person)
                    }
                }
            } // LazyVGrid
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    GridLayout(people: Person.examplePeople)
}
