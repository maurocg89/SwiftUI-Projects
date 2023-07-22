//
//  UserDetailView.swift
//  FirendFace
//
//  Created by Mauro Grillo on 20/07/2023.
//

import SwiftUI

struct UserDetailView: View {
    let user: User

    var userInitials: String {
        let nameComponents = user.name.components(separatedBy: .whitespaces)
        return "\(nameComponents.first?.first ?? " ")\(nameComponents.last?.first ?? " ")"
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                VStack {
                    InitialsCircleView(initials: userInitials)
                        .frame(maxWidth: geometry.size.width * 0.2)

                    Text(user.name)
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } // VStack
                .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.2)

                Form {
                    Section("Info") {
                        UserDetailRowView(title: "Name", value: user.name)
                        UserDetailRowView(title: "Age", value: String(user.age))
                        UserDetailRowView(title: "Company", value: user.company)
                        UserDetailRowView(title: "Email", value: user.email)
                        UserDetailRowView(title: "Address", value: user.address)
                        UserDetailRowView(title: "About", value: user.about)
                    }
                    Section("Friends") {
                        List(user.friends, id: \.id) { friend in
                            Text(friend.name)
                        }
                    }
                } // Form
            } // VStack
        } // GeometryReader
        .navigationTitle("User Detail")
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
        UserDetailView(user: User())
    }
}
