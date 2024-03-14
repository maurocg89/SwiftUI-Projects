//
//  AstronautView.swift
//  Moonshot
//
//  Created by Mauro Grillo on 27/05/2023.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(decorative: astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String:Astronaut] = Bundle.main.decode("astronauts.json")
    return AstronautView(astronaut: astronauts["armstrong"]!)
        .preferredColorScheme(.dark)
}
