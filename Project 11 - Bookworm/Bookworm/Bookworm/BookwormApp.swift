//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Mauro Grillo on 05/07/2023.
//

import SwiftUI

@main
struct BookwormApp: App {
//    @StateObject private var dataController = DataControllerPlayground()
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
//            CoreDataPlayground()
//                .environment(\.managedObjectContext, dataController.container.viewContext)
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
