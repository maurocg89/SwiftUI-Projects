//
//  SyncWithCloudKit.swift
//  SwiftDataProject
//
//  Created by Mauro Grillo on 09/02/2024.
//

import SwiftUI

// Require active Apple developer account
// First we need to enable iCloud capability and check CloudKit
// Then we need to create a new container where to store data
// After that we need to add 'background mode' capability and check Remote notifications (this allows the app to be notified when there are iCloud changes to be synchronized locally with SwfitData)
// Cloud kit requires all attributes to be optional or have a default value set (Check JobCloudKit model)

struct SyncWithCloudKit: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SyncWithCloudKit()
}
