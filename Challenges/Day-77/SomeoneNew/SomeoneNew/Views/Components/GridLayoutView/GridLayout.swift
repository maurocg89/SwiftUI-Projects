//
//  GridLayoutView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 15/10/2023.
//

import SwiftUI

struct GridLayout: View {
    @Binding var people: [Person]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach($people) { person in
                    NavigationLink {
                        PersonDetailView(selectedPersonId: person.id)
                    } label: {
                        PersonCardView(person: person, showingGrid: true)
                    }
                }
            } // LazyVGrid
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    GridLayout(people: .constant(Person.examplePeople))
}
