//
//  PersonDetailView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 17/10/2023.
//

import SwiftUI

struct PersonDetailView: View {
    let person: Person

    var body: some View {
        ZStack {
            backgroundColor()
            Text(person.name)
        }
    }
}

#Preview {
    PersonDetailView(person: Person.example)
}
