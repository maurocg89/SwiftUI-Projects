//
//  GradientPlayground.swift
//  GuessTheFlag
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct GradientPlayground: View {
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(stops: [
                 .init(color: .white, location: 0.45),
                 .init(color: .black, location: 0.55),
             ]), startPoint: .top, endPoint: .bottom)
            
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
            
            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
        }
    }
}

struct GradientPlayground_Previews: PreviewProvider {
    static var previews: some View {
        GradientPlayground()
    }
}
