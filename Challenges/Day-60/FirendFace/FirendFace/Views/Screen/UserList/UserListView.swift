//
//  UserListView.swift
//  FirendFace
//
//  Created by Mauro Grillo on 20/07/2023.
//

import SwiftUI

struct UserListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor<CachedUser>(\.name)]) var cachedUsers: FetchedResults<CachedUser>

    @StateObject private var usersWrapper = UserListWrapper()
    @State private var searchText = ""
    @State private var isLoading = false

    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .leading) {
                if isLoading {
                    ProgressView()
                } else {
                    List(cachedUsers, id: \.id) { cachedUser in
//                        let user = User(from: cachedUser)
                        NavigationLink {
                            UserDetailView(user: cachedUser)
                        } label: {
                            UserRowView(user: cachedUser)
                        }
                    }
//                    .searchable(text: $searchText)
                    .searchable(text: query)
                }
            }
            
            if isLoading {
                ProgressView()
            } else {
                if cachedUsers.isEmpty {
                    Text("No users found")
                }
            }
        }
        .navigationTitle("FriendFace")
        .task {
            // Update the user database from the network only when the user opens the app
            if usersWrapper.userList.isEmpty {
                await getUsers()
            }
        }
    }

    func getUsers() async {
        defer {
            isLoading = false
        }
        isLoading = true
        if let users = await NetworkManager().getUsers() {
            self.usersWrapper.userList = users
            await updateCachedUsers(userList: users)
        }
    }

    private func updateCachedUsers(userList: [User]) async {
        await MainActor.run {
            for user in userList {
                let cachedUser = CachedUser(context: moc)
                cachedUser.id = user.id
                cachedUser.isActive = user.isActive
                cachedUser.about = user.about
                cachedUser.address = user.address
                cachedUser.age = Int16(user.age)
                cachedUser.company = user.company
                cachedUser.email = user.email
                cachedUser.name = user.name
                cachedUser.formattedDate = user.formattedDate

                user.friends.forEach { friend in
                    let cachedFriend = CachedFriend(context: moc)
                    cachedFriend.id = friend.id
                    cachedFriend.name = friend.name
                    cachedFriend.user = cachedUser
                }
            }
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }

    // Two options to use searchable
    var searchResult: [CachedUser] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return cachedUsers.compactMap { $0 }
        } else {
            return cachedUsers.filter { $0.wrappedName.contains(searchText) }
        }
    }

    var query: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            searchText = newValue
            if newValue.isEmpty {
                cachedUsers.nsPredicate = NSPredicate(value: true)
            } else {
                cachedUsers.nsPredicate = NSPredicate(format: "name CONTAINS[cd] %@", newValue)
            }
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
