//
//  UserListView.swift
//  FirendFace
//
//  Created by Mauro Grillo on 20/07/2023.
//

import SwiftUI

// TODO: Add a search bar
struct UserListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor<CachedUser>(\.name)]) var cachedUsers: FetchedResults<CachedUser>

    @StateObject private var usersWrapper = UserListWrapper()
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
                }
            }
            
            if isLoading {
                ProgressView()
            } else {
                if cachedUsers.isEmpty {
                    Text("There are no users")
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
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
