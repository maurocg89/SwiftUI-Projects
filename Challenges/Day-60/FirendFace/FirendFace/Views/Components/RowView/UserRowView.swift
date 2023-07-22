//
//  UserRowView.swift
//  FirendFace
//
//  Created by Mauro Grillo on 21/07/2023.
//

import SwiftUI

struct UserRowView: View {
    let user: User

    var userInitials: String {
        let nameComponents = user.name.components(separatedBy: .whitespaces)
        return "\(nameComponents.first?.first ?? " ")\(nameComponents.last?.first ?? " ")"
    }

    var body: some View {
        HStack {
            InitialsCircleView(initials: userInitials)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading) {
                Text(user.name)
                    .fontWeight(.bold)
                
                Text("Active: \(String(user.isActive))")
            }
        }
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User())
    }
}
