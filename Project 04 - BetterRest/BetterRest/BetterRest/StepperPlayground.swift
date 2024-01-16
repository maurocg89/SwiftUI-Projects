//
//  StepperPlayground.swift
//  BetterRest
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct StepperPlayground: View {
    @State private var sleepAmount = 8.0
    
    var body: some View {
        Stepper("\(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
            .padding()
    }
}

struct StepperPlayground_Previews: PreviewProvider {
    static var previews: some View {
        StepperPlayground()
    }
}
