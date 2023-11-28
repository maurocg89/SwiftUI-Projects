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
    var imageData: Data

    static func ==(lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
}

extension Person {
    var image: UIImage? {
        UIImage(data: imageData)
    }

    static let example = Person(id: UUID(), name: "Mauro", lastName: "Grillo", imageData: Data())

    static let examplePeople: [Person] = [
        Person(id: UUID(), name: "John", lastName: "Doe", imageData: Data()),
        Person(id: UUID(), name: "Sean", lastName: "Allen", imageData: Data()),
        Person(id: UUID(), name: "Paul", lastName: "Hudson", imageData: Data()),
        Person(id: UUID(), name: "Steve", lastName: "Jobs", imageData: Data()),
        Person(id: UUID(), name: "Taylor", lastName: "Swift", imageData: Data())
    ]
}
