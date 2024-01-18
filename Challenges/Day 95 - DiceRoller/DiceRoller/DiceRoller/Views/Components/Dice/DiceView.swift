//
//  DiceView.swift
//  DiceRoller
//
//  Created by Mauro Grillo on 16/01/2024.
//

import SwiftUI

struct DiceView: View {
    @Binding var numberOfDots: Int
    let size = 80.0

    var body: some View {
        Image(systemName: "die.face.\(numberOfDots)")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

#Preview {
    DiceView(numberOfDots: .constant(4))
}
