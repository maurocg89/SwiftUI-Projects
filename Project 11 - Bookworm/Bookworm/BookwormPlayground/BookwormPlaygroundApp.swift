//
//  BookwormPlaygroundApp.swift
//  BookwormPlayground
//
//  Created by Mauro Grillo on 21/03/2024.
//

import SwiftUI

@main
struct BookwormPlaygroundApp: App {
//    @StateObject private var dataController = DataControllerPlayground()

    var body: some Scene {
        WindowGroup {
            SwiftDataPlayground()
//            CoreDataPlayground()
//                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
        .modelContainer(for: StudentData.self)
        // The job of the model context is to let us work with all our data in memory
        // A temporary pool of memory
        // It's made automatically (called main context) when we have this modelContainer(for:) and stores it inside the SwiftUI Environment
    }
}
