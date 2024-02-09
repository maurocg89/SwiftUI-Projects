//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Mauro Grillo on 05/07/2023.
//

import SwiftUI

// MARK: CoreData
//@main
//struct BookwormApp: App {
////    @StateObject private var dataController = DataControllerPlayground()
//    @StateObject private var dataController = DataController()
//
//    var body: some Scene {
//        WindowGroup {
////            CoreDataPlayground()
////                .environment(\.managedObjectContext, dataController.container.viewContext)
//            ContentViewCD()
//                .environment(\.managedObjectContext, dataController.container.viewContext)
//        }
//    }
//}

// MARK: Update for iOS 17 and SwiftData
@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentViewSD()
        }
        .modelContainer(for: BookModel.self)
    }
}
