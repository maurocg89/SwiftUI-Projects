//
//  HidingAndGroupingA11YData.swift
//  AccessibilitySandbox
//
//  Created by Mauro Grillo on 23/09/2023.
//

import SwiftUI

struct HidingAndGroupingA11YData: View {
    var body: some View {
        ZStack {
            Image(decorative: "character")
                .accessibilityHidden(true) // Make inivisible to VoiceOver
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)
            }
//            .accessibilityElement(children: .combine) // Read them together
            .accessibilityElement(children: .ignore) // Make inivisible to VoiceOver, we can now use our own label
            .accessibilityLabel("Your score is 1000")

        }
    }
}

struct HidingAndGroupingA11YData_Previews: PreviewProvider {
    static var previews: some View {
        HidingAndGroupingA11YData()
    }
}
