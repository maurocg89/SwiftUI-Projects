//
//  NavigationStackPlayground.swift
//  Navigation
//
//  Created by Mauro Grillo on 02/02/2024.
//

import SwiftUI

struct DetailView: View {
    var number: Int

    var body: some View {
        Text("Detail View \(number)")
    }

    init(number: Int) {
        self.number = number
        print("Creating detail view \(number)")
    }
}

// Because UUID, String and Int conforms to Hashable we can say Student also conforms to Hashable.
struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
}

struct PresentationValuesPlayground: View {
    var body: some View {
        NavigationStack {
//            NavigationLink("Tap Me") {
//                // Initialize the DetailView before tapping the NavigationLink. With one View it's not a big deal, but if we have, for example, a List with NavigationLinks inside, these are created before we need them.
//                DetailView(number: 556)
//            }
//            List(0..<100) { i in
//                NavigationLink("Tap Me") {
//                    DetailView(number: i)
//                }
//            }

            // Solution for the NavigationLink initialization
            // Value must conform to Hashable
            // Hashing is the process of converting some data into a smaller representation of it in a consistent way.
            List(0..<100) { i in
                NavigationLink("Select \(i)", value: i)
            }
            // When SwiftUI attempts to navigate to any Int value give us the actual Int (selection) and we return the correct View for that.
            // We can add several navigation destination modifiers for all the value types that we need to display.
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
            .navigationDestination(for: Student.self) { student in
                Text("You selected \(student.name)")
            }

        }
    }
}

#Preview {
    PresentationValuesPlayground()
}
