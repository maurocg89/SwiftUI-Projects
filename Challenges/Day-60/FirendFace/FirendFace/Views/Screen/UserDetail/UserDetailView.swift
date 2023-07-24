//
//  UserDetailView.swift
//  FirendFace
//
//  Created by Mauro Grillo on 20/07/2023.
//

import SwiftUI

struct UserDetailView: View {
    let user: CachedUser

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                VStack {
                    InitialsCircleView(initials: user.userInitials, isActive: user.isActive)
                        .frame(maxWidth: geometry.size.width * 0.2)

                    Text(user.wrappedName)
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text(user.wrappedEmail)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } // VStack
                .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.2)

                Form {
                    Section("Info") {
                        UserDetailRowView(title: "Name", value: user.wrappedName)
                        UserDetailRowView(title: "Age", value: String(user.age))
                        UserDetailRowView(title: "Company", value: user.wrappedCompany)
                        UserDetailRowView(title: "Email", value: user.wrappedEmail)
                        UserDetailRowView(title: "Address", value: user.wrappedAddress)
                        UserDetailRowView(title: "About", value: user.wrappedAbout)
                    }
                    Section("Friends") {
                        List(user.friendArray, id: \.id) { friend in
                            Text(friend.wrappedName)
                        }
                    }
                } // Form
            } // VStack
        } // GeometryReader
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGray6))
    }
}

struct UserDetailRowView: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.footnote)
                .fontWeight(.bold)
            Text(value)
                .font(.subheadline)
                .padding(.top, 1)
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: CachedUser())
    }
}
