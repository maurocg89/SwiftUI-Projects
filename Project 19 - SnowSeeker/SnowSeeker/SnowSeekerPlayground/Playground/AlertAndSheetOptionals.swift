//
//  AlertAndSheetOptionals.swift
//  SnowSeeker
//
//  Created by Mauro Grillo on 23/01/2024.
//

import SwiftUI
// Using alert() and sheet() with optionals

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct AlertAndSheetOptionals: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false

    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                selectedUser = User()
                isShowingUser = true
            }
        // We are saying that we want the sheet to be shown when selectedUser has a value.
            .sheet(item: $selectedUser) { user in
                Text(user.id)
            }
            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
                Button(user.id){}
            }
    }
}

#Preview {
    AlertAndSheetOptionals()
}
