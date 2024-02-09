//
//  SwiftDataPlayground.swift
//  Bookworm
//
//  Created by Mauro Grillo on 08/02/2024.
//

import SwiftData
import SwiftUI

struct SwiftDataPlayground: View {
    @Environment(\.modelContext) var modelContext
    // With 'Query' SwiftData load students from its model container
    @Query var students: [StudentData]

    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                    let choosenFirstName = firstNames.randomElement()!
                    let choosenLastName = lastNames.randomElement()!

                    let student = StudentData(id: UUID(), name: "\(choosenFirstName) \(choosenLastName)")
                    modelContext.insert(student)
                }
            }
        }
    }
}

#Preview {
    SwiftDataPlayground()
}
