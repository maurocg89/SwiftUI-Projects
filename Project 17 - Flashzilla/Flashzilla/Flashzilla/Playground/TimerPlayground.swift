//
//  TimerPlayground.swift
//  Flashzilla
//
//  Created by Mauro Grillo on 05/01/2024.
//

import SwiftUI

struct TimerPlayground: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 1
    @State private var timeDescription = ""

    var body: some View {
        Text("The time is now: \(timeDescription)")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                }
                counter += 1
                timeDescription = time.formatted(date: .omitted, time: .standard)
                print("The time is now \(time)")
            }
    }
}

#Preview {
    TimerPlayground()
}
