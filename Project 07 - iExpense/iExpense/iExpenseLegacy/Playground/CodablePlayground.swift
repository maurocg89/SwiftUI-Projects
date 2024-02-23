//
//  CodablePlayground.swift
//  iExpense
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct UserCodable: Codable {
    let firstName: String
    let lastName: String
}


struct CodablePlayground: View {
    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()

            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct CodablePlayground_Previews: PreviewProvider {
    static var previews: some View {
        CodablePlayground()
    }
}
