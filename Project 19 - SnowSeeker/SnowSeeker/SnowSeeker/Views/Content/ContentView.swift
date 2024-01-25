//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Mauro Grillo on 22/01/2024.
//

import SwiftUI

struct ContentView: View {
    enum SortOrder {
        case byDefault, byName, byCountryName
    }

    let resorts: [Resort] = Bundle.main.decode(Resort.resortsFileName)
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    @State private var sortOrder: SortOrder = .byDefault

    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
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

                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }

                } // NavigationLink
            } // List
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Default")
                            .tag(SortOrder.byDefault)
                        Text("Sort by Name")
                            .tag(SortOrder.byName)
                        Text("Sort by Country")
                            .tag(SortOrder.byCountryName)
                    }
                }
            }
            // Detail View for the landscape orientation.
            WelcomeView()

        } // NavigationView
        .environmentObject(favorites)
        // Force view in compact mode on iPhones with larger screens (Pro Max) in landscape orientation.
//        .phoneOnlyNavigationView()
    }

    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts.sorted(by: sortResorts)
        }
        return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            .sorted(by: sortResorts)
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

    // MARK: Private Functions
    private func sortResorts(_ resort1: Resort, _ resort2: Resort) -> Bool {
        switch sortOrder {
        case .byDefault:
            return false
        case .byName:
            return resort1.name < resort2.name
        case .byCountryName:
            return resort1.country < resort2.country
        }
    }
}

#Preview {
    ContentView()
}
