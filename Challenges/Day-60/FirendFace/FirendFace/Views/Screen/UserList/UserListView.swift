//
//  UserListView.swift
//  FirendFace
//
//  Created by Mauro Grillo on 20/07/2023.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var users = UserListWrapper()
    @State private var isLoading = false

    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .leading) {
                if isLoading {
                    ProgressView()
                } else {
                    List(users.userList, id: \.id) { user in
                        NavigationLink {
                            UserDetailView(user: user)
                        } label: {
                            UserRowView(user: user)
                        }
                    }
                }
            }
            
            if isLoading {
                ProgressView()
            } else {
                if users.userList.isEmpty {
                    Text("There are no users")
                }
            }
        }
        .navigationTitle("User List")
        .task {
            if users.userList.isEmpty {
                await getUsers()
            }
        }
    }

    func getUsers() async {
        defer {
            isLoading = false
        }
        isLoading = true
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let decoded = try? JSONDecoder().decode([User].self, from: data) {
                self.users.userList = decoded
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
