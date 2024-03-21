//
//  ComparablePlaygroundView.swift
//  BucketList
//
//  Created by Mauro Grillo on 17/08/2023.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String

    // Must be static and return a Bool
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }

}

struct ComparablePlaygroundView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "List")
    ]
    // Ideally we don't use it this way. We conform the Comparable protocol in the User struct
//    .sorted {
//        $0.lastName < $1.lastName
//    }
    .sorted()

    var body: some View {
        List(users) { user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

struct ComparablePlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        ComparablePlaygroundView()
    }
}
