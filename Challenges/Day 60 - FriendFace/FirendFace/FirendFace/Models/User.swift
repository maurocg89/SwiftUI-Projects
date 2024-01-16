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

    var about = ""
    var address = ""
    var age: Int16 = 0
    var company = ""
    var email = ""
    var friends: [Friend] = []
    var name = ""
    var registered = Date()

    var formattedDate: String {
        registered.formatted(date: .abbreviated, time: .omitted)
    }
//
//    init(){}
//
//    init(from cachedUser: CachedUser) {
//        self.id = cachedUser.id ?? UUID().uuidString
//        self.isActive = cachedUser.isActive
//        self.about = cachedUser.wrappedAbout
//        self.address = cachedUser.wrappedAddress
//        self.age = cachedUser.age
//        self.company = cachedUser.wrappedCompany
//        self.email = cachedUser.wrappedEmail
//        self.friends = cachedUser.friendArray.map { Friend(from: $0) }
//        self.name = cachedUser.wrappedName
//    }
}
