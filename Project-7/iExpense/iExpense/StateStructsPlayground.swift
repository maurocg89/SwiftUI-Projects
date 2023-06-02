//
//  StateStructsPlayground.swift
//  iExpense
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct UserPlayground {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

class UserPlaygroundClass {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct StateStructsPlayground: View {
    @State private var user = UserPlayground()
    // State not watch values inside the class that why is not update the view. Change internally but not reflect the change in the UI. We need to use StateObject with classes
    @State private var userClass = UserPlaygroundClass()
    
    var body: some View {
        VStack {
            Text("Struct: Your name is \(user.firstName) \(user.lastName)")
            
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
            
            Text("Class: Your name is \(userClass.firstName) \(userClass.lastName)")
            
            TextField("First Name", text: $userClass.firstName)
            TextField("Last Name", text: $userClass.lastName)
        }
        .padding()
    }
}

struct StateStructsPlayground_Previews: PreviewProvider {
    static var previews: some View {
        StateStructsPlayground()
    }
}
