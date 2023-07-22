//
//  User.swift
//  FirendFace
//
//  Created by Mauro Grillo on 20/07/2023.
//

import Foundation

struct User: Codable, Identifiable {
    var id = ""
    var isActive = false
    var name = ""
    var age = 0
    var company = ""
    var email = ""
    var address = ""
    var about = ""
    var friends: [Friend] = []
}
