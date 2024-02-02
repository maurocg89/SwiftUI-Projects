//
//  HashablePlaygroundView.swift
//  CoreDataProject
//
//  Created by Mauro Grillo on 07/07/2023.
//

import SwiftUI

// To use /.self all the properties of a Hashable object must also be Hashable. When we use /.self in a ForEach or List as KeyPath id, Swift assigns a unique hash to each object to identify them.

struct Student: Hashable {
    let name: String
    let age: Int
}

struct HashablePlaygroundView: View {
    let students = [Student(name: "Harry Potter", age: 18), Student(name: "Hermione Granger", age: 18)]

    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

struct HashablePlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        HashablePlaygroundView()
    }
}
