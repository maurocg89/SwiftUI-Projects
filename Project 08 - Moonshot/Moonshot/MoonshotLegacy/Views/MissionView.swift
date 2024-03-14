//
//  MissionView.swift
//  MoonshotLegacy
//
//  Created by Mauro Grillo on 24/02/2024.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
           GeometryReader { geometry in
               ScrollView {
                   VStack {
                       Image(decorative: mission.image)
                           .resizable()
                           .scaledToFill()
                           .frame(maxWidth: geometry.size.width * 0.6)
                           .padding(.top)

                       Text("Launch date: \(mission.formattedLaunchDate)")
                           .font(.title3.bold())
                           .padding()

                       Divider()
                           .padding([.bottom, .horizontal])

                       VStack(alignment: .leading) {
                           Text("Mission Highlights")
                               .font(.title.bold())
                               .padding(.bottom, 5)

                           Text(mission.description)

                       } // VStack
                       .padding(.horizontal)

                       VStack(alignment: .leading) {
                           Divider()
                               .padding()

                           Text("Crew")
                               .font(.title.bold())
                               .padding(.bottom, 5)
                       }
                       .padding(.horizontal)

                       ScrollView(.horizontal, showsIndicators: false) {
                           CrewView(crew: crew)
                       } // ScrollView
                   } // VStack
                   .padding(.bottom)
               } // ScrollView (vertical)
           } // GeometryReader
           .navigationTitle(mission.displayName)
           .navigationBarTitleDisplayMode(.inline)
           .background(.darkBackground)
       }

    init(mission: Mission, astronauts: [String:Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String:Astronaut] = Bundle.main.decode("astronauts.json")

    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
