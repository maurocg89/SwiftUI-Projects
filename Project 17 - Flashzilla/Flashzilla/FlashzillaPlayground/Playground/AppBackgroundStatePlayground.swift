//
//  AppBackgroundStatePlayground.swift
//  Flashzilla
//
//  Created by Mauro Grillo on 05/01/2024.
//

import SwiftUI

struct AppBackgroundStatePlayground: View {
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        Text("Hello, World!")
            .onChange(of: scenePhase) { _, newPhase in
                if newPhase == .active {
                    print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

#Preview {
    AppBackgroundStatePlayground()
}
