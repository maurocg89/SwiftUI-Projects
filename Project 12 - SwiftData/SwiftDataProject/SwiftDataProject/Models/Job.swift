//
//  Job.swift
//  SwiftDataProject
//
//  Created by Mauro Grillo on 09/02/2024.
//

import Foundation
import SwiftData

@Model
class Job {
    var name: String
    var priority: Int
    var owner: User? // Both way relationship

    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}
