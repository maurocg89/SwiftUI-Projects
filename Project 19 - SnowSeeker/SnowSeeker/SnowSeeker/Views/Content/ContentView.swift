//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Mauro Grillo on 22/01/2024.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode(Resort.resortsFileName)

    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        }

                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundStyle(.secondary)
                    }
                }
            } // List
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")

            // Detail View for the landscape orientation.
            WelcomeView()

        } // NavigationView
        // Force view in compact mode on iPhones with larger screens (Pro Max) in landscape orientation.
//        .phoneOnlyNavigationView()
    }

    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        }
        return resorts.filter{ $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    // Updated for Xcode 15 and iOS 16
    private var navigationSplitView: some View {
        NavigationSplitView {
            List(resorts) { resort in
                NavigationLink {
                    Text(resort.name)
                } label: {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        }

                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundStyle(.secondary)
                    }
                }
            } // List
            .navigationTitle("Resorts")
        } detail: {
            // Detail View for the landscape orientation.
            WelcomeView()
        } // NavigationSplitView
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
