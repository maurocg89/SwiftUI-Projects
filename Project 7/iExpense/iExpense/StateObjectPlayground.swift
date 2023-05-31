//
//  StateObjectPlayground.swift
//  iExpense
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

class UserClassPlayground: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct StateObjectPlayground: View {
    @StateObject var user = UserClassPlayground()

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

struct StateObjectPlayground_Previews: PreviewProvider {
    static var previews: some View {
        StateObjectPlayground()
    }
}
