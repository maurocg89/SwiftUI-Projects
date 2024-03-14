//
//  CrewView.swift
//  Moonshot
//
//  Created by Mauro Grillo on 24/02/2024.
//

import SwiftUI

struct CrewView: View {
    let crew: [CrewMember]

    var body: some View {
        HStack {
            ForEach(crew, id: \.role) { crewMember in
                NavigationLink {
                    AstronautView(astronaut: crewMember.astronaut)
                } label: {
                    HStack {
                        Image(crewMember.astronaut.id)
                            .resizable()
                            .frame(width: 104, height: 72)
                            .clipShape(.capsule)
                            .overlay(Capsule()
                                .strokeBorder(.white, lineWidth: 1)
                            )
                        VStack(alignment: .leading) {
                            Text(crewMember.astronaut.name)
                                .foregroundStyle(.white)
                                .font(.headline)

                            Text(crewMember.role)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.horizontal, 5)
                } // NavigationLink
            } // ForEach
        } // HStack
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String:Astronaut] = Bundle.main.decode("astronauts.json")
    let crew = missions[0].crew.map { member in
        return CrewMember(role: member.role, astronaut: astronauts[member.name] ?? Astronaut(id: "1", name: "Preview Name", description: "Preview Description"))
    }
    return CrewView(crew: crew)
}
