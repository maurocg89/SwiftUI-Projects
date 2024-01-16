//
//  UserDefaultsPlayground.swift
//  iExpense
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct UserDefaultsPlayground: View {
//    @State private var tapCount = 0
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage("tapCount") private var tapCountState = 0

    var body: some View {
        VStack(spacing: 10) {
            Button("Tap count: \(tapCount)") {
                tapCount += 1
                UserDefaults.standard.set(tapCount, forKey: "Tap")
            }
            
            Button("Tap Storage count: \(tapCountState)") {
                tapCountState += 1
            }
        }
    }
}

struct UserDefaultsPlayground_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsPlayground()
    }
}
