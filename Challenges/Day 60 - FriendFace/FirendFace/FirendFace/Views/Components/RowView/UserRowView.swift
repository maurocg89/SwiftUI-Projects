//
//  UserRowView.swift
//  FirendFace
//
//  Created by Mauro Grillo on 21/07/2023.
//

import SwiftUI

struct UserRowView: View {
    let user: CachedUser

    var body: some View {
        HStack {
            InitialsCircleView(initials: user.userInitials, isActive: user.isActive)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading) {
                Text(user.wrappedName)
                    .fontWeight(.bold)
                
                Text(user.isActive ? "Active" : "Offline")
                    .foregroundColor(user.isActive ? Color.green : Color(.lightGray))
                    .fontWeight(.semibold)
                    .font(.footnote)
            }
        }
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: CachedUser())
    }
}
