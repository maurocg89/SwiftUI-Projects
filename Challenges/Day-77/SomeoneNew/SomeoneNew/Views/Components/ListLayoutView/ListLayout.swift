//
//  ListLayout.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 13/12/2023.
//

import SwiftUI

struct ListLayout: View {
    @Binding var people: [Person]
    
    var body: some View {
        List($people) { person in
            PersonCardView(person: person, showingGrid: false)
                .background(NavigationLink("", destination: PersonDetailView(selectedPersonId: person.id))
                    .opacity(0)
                )
                .listRowBackground(Color.backgroundColor)
                .listRowSeparator(.visible)
        }
    }
}

#Preview {
    ListLayout(people: .constant(Person.examplePeople))
}
