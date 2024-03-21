//
//  BookwormCoreDataApp.swift
//  BookwormCoreData
//
//  Created by Mauro Grillo on 21/03/2024.
//

import SwiftUI

@main
struct BookwormCoreDataApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
