//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Mauro Grillo on 09/02/2024.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]

    var body: some View {
        List(users) { user in
            HStack {
                Text(user.name)
                
                Spacer()

                Text("\(user.jobs.count)")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(.circle)
            }
        }
        .onAppear(perform: addSample)
    }

    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        // We aren't trying to change the users array, we are trying to change the underlying Swift data query that produces the array. This '_' is Swifty's way of getting access of that query behind the actual array, that means we are making a new Query object. We are not making the array, we are making the query that makes the array.
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }

    func addSample() {
        let user1 = User(name: "Piper Chapman", city: "New York", joinDate: .now)
        let job1 = Job(name: "Organize sock drawer", priority: 3)
        let job2 = Job(name: "Make plans with Alex", priority: 4)
        modelContext.insert(user1)
        
        // SwiftData automatically insert job1 and job2, and link them to 'user1'.
        // If we delete user1 from modelContext the jobs remain intact, they don't get deleted. We need to add the 'Cascade' delete rule to delete all relationship objects when its owning user is deleted.
        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
