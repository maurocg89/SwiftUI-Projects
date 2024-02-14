//
//  User.swift
//  SwiftDataProject
//
//  Created by Mauro Grillo on 09/02/2024.
//

import Foundation
import SwiftData

// @Model is a macro, builds on the same observation system as @Observable.
// Conforms to Identifiable protocol automatically
@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    @Relationship(deleteRule: .cascade) var jobs = [Job]()
//    var jobs = [Job]() // Both way relationship
    // SwiftData will load all the jobs for a user when they are first requested, so if they are never used at all it will just skip that work. Even better, the next time our app launches SwifData will silently add the jobs property to all its existing users, giving them an empty array by default. This is called a migration.

    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
