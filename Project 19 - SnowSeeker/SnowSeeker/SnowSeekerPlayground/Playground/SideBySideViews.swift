//
//  SideBySideViews.swift
//  SnowSeeker
//
//  Created by Mauro Grillo on 23/01/2024.
//

import SwiftUI
// Working with two side by side views in SwiftUI

struct SideBySideViews: View {
    // Primary view controls Secondary, Secondary view controls Tertiary.
    var body: some View {
        NavigationView {
            NavigationLink {
                Text("New secondary")
            } label: {
                Text("Hello, World!")
            }
            .navigationTitle("Primary")
            // Primary View. It depends on the size of the device how it is displayed.
//            Text("Hello, World!")
//                .navigationTitle("Primary")

            Text("Secondary")

            Text("Tertiary")
        }
    }
}

#Preview {
    SideBySideViews()
}
