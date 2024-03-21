//
//  Student.swift
//  Bookworm
//
//  Created by Mauro Grillo on 08/02/2024.
//

import Foundation
import SwiftData

@Model // SwiftData Model
class StudentData {
    var id: UUID
    var name: String

    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
