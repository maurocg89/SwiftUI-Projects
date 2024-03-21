//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Mauro Grillo on 05/07/2023.
//

import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentViewSD()
        }
        .modelContainer(for: BookModel.self)
    }
}
