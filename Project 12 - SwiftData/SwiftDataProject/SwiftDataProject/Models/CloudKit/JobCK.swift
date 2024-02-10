//
//  JobCK.swift
//  SwiftDataProject
//
//  Created by Mauro Grillo on 09/02/2024.
//

import Foundation
import SwiftData

// MARK: Job class changes to meet CloudKit requirements
// - All properties must be optional or have a default value set
// - All relationship must be optional
@Model
class JobCK {
    var name: String = ""
    var priority: Int = 1
    var owner: User?

    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}
