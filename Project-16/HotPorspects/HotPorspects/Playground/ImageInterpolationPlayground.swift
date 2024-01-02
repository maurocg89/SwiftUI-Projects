//
//  ImageInterpolationPlayground.swift
//  HotPorspects
//
//  Created by Mauro Grillo on 02/01/2024.
//

import SwiftUI

struct ImageInterpolationPlayground: View {
    var body: some View {
        Image("example")
            .interpolation(.none) // Turn off interpolation to remove the blur and get the original pixels stretched up.
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

#Preview {
    ImageInterpolationPlayground()
}
