//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Mauro Grillo on 07/07/2023.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            OneToManyRelationshipView()
//            DynamicFilteringView()
//            NSPredicatePlaygroundView()
//            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
