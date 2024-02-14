//
//  ProspectSD.swift
//  HotPorspects
//
//  Created by Mauro Grillo on 14/02/2024.
//

import SwiftData
import SwiftUI

@Model
class ProspectSD {
    var name: String
    var emailAddress: String
    var isContacted: Bool

    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
