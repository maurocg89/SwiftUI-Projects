//
//  EditingModelObjectsView.swift
//  SwiftDataProject
//
//  Created by Mauro Grillo on 09/02/2024.
//

import SwiftData
import SwiftUI

// SwiftData's model objects are powered by the same observation system that makes @Observable classes work, which means changes to the model objects are automatically picked up by SwiftUI so that our data an our UI stay in sync

struct EditUserView: View {
    @Bindable var user: User

    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let previewUser = User(name: "Taylor Swift", city: "Nashville", joinDate: .now)

        return EditUserView(user: previewUser)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }

}
