//
//  ListLayout.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 13/12/2023.
//

import SwiftUI

struct ListLayout: View {
    @Binding var people: [Person]
    var onDelete: ((UUID) -> Void)?

    var body: some View {
        List {
            ForEach($people) { person in
                PersonCardView(person: person, showingGrid: false)
                    .background(NavigationLink("", destination: PersonDetailView(selectedPersonId: person.id))
                        .opacity(0)
                    )
                    .listRowBackground(Color.backgroundColor)
                    .listRowSeparator(.visible)
            }
            .onDelete(perform: delete(at:))
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let person = people[index]
            onDelete?(person.id)
        }
        people.remove(atOffsets: offsets)
    }
}

#Preview {
    ListLayout(people: .constant(Person.examplePeople))
}
