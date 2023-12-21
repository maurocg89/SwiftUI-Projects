//
//  Person.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 15/10/2023.
//

import Foundation
import UIKit

struct Person: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var lastName: String
    var description: String
    var imageData: Data
    var location: Location?

    static func ==(lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
}

extension Person {
    var image: UIImage? {
        UIImage(data: imageData)
    }

    static let empty = Person(id: UUID(), name: "", lastName: "", description: "", imageData: Data())

    static let example = Person(id: UUID(), name: "Mauro", lastName: "Grillo", description: "I met him in the park", imageData: Data(), location: Location.example)

    static let examplePeople: [Person] = [
        Person(id: UUID(), name: "John", lastName: "Doe", description: "I met him in the park", imageData: Data(), location: Location.example),
        Person(id: UUID(), name: "Sean", lastName: "Allen", description: "iOS Developer and Content creator", imageData: Data(), location: Location.example),
        Person(id: UUID(), name: "Paul", lastName: "Hudson", description: "iOS Developer and Content creator", imageData: Data(), location: Location.example),
        Person(id: UUID(), name: "Steve", lastName: "Jobs", description: "Co-Founder of Apple", imageData: Data(), location: Location.example),
        Person(id: UUID(), name: "Taylor", lastName: "Swift", description: "Singer", imageData: Data(), location: Location.example)
    ]
}
