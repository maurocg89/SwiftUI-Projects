//
//  DataController.swift
//  Bookworm
//
//  Created by Mauro Grillo on 06/07/2023.
//

import CoreData
import Foundation

class DataControllerPlayground: ObservableObject {
    let container = NSPersistentContainer(name: "BookwormPlayground")

    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            
        }
    }
}

