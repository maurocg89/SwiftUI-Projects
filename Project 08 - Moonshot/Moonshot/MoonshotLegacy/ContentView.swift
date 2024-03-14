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
        NavigationView {
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
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        MissionCardView(mission: mission)
                    }
                }
            } // LazyVGrid
            .padding([.horizontal, .bottom])
        }
    }
}

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String : Astronaut]

    var body: some View {
        List(missions) { mission in
            MissionCardView(mission: mission)
                .background(NavigationLink("", destination: MissionView(mission: mission, astronauts: astronauts)).opacity(0))
                .listRowBackground(Color.darkBackground)
                .listRowSeparator(.hidden)
                .accessibility(addTraits: .isLink)
                .accessibility(removeTraits: .isButton)
        }
        .background(Color.darkBackground.ignoresSafeArea())
        .listStyle(.insetGrouped)
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
    }
}

#Preview {
    ContentView()
}
