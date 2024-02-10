//
//  UserCloudKit.swift
//  SwiftDataProject
//
//  Created by Mauro Grillo on 09/02/2024.
//

import SwiftData
import Foundation

// MARK: User class changes to meet CloudKit requirements
// - All attributes must be optional, or have a default value set
// - All relationship must be optional

@Model
class UserCK {
    var name: String = "Anonymous"
    var city: String = "Unknown"
    var joinDate: Date = Date.now
    @Relationship(deleteRule: .cascade) var jobs: [Job]? = [Job]()

    var unwrappedJobs: [Job] {
        jobs ?? []
    }

    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
