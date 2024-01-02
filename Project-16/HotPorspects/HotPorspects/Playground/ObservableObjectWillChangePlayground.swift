//
//  ObservableObjectWillChangePlayground.swift
//  HotPorspects
//
//  Created by Mauro Grillo on 02/01/2024.
//

import SwiftUI

@MainActor class DelayedUpdater: ObservableObject {
    @Published var value = 0
    var value2 = 0 {
        willSet {
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
                self.value2 += 1
            }
        }
    }
}

struct ObservableObjectWillChangePlayground: View {
    @StateObject private var updater = DelayedUpdater()

    var body: some View {
        Text("Value is \(updater.value)")
        Text("Manually publishing change value is: \(updater.value2)")
    }
}

#Preview {
    ObservableObjectWillChangePlayground()
}
