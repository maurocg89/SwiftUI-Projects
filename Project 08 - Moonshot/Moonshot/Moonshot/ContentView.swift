//
//  ContentView.swift
//  Moonshot
//
//  Created by Mauro Grillo on 08/05/2023.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridLayout(missions: missions, astronauts: astronauts)
                } else {
                    ListLayout(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(showingGrid ? "Show List" : "Show Grid") {
                    self.showingGrid.toggle()
                }
            }
        }
    }
}

struct GridLayout: View {
    let missions: [Mission]
    let astronauts: [String : Astronaut]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    // MARK: Project 9 Challenge 3. Navigation
                    NavigationLink(value: mission) {
                        MissionCardView(mission: mission)
                    }
                }
            } // LazyVGrid
            .padding([.horizontal, .bottom])
        }
        .navigationDestination(for: Mission.self) { missionDestination in
            MissionView(mission: missionDestination,
                        astronauts: astronauts)
        }
    }
}

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String : Astronaut]

    // MARK: Project 9 Challenge 3. Navigation
    var body: some View {
        List(missions) { mission in
            MissionCardView(mission: mission)
                .background(
                    NavigationLink("", value: mission)
                        .opacity(0))
                .listRowBackground(Color.darkBackground)
                .listRowSeparator(.hidden)
                .accessibility(addTraits: .isLink)
                .accessibility(removeTraits: .isButton)
        }
        .navigationDestination(for: Mission.self, destination: { missionDestination in
            MissionView(mission: missionDestination, astronauts: astronauts)
        })
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    ContentView()
}
