//
//  PeopleListView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 15/10/2023.
//

import SwiftUI

struct PeopleListView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor()
                VStack {
                    if viewModel.showingGrid {
                        GridLayout(people: $viewModel.people)
                    } else {
                        ListLayout(people: $viewModel.people)
                    }
                    Button("Reset Data", role: .destructive) {
                        viewModel.resetData()
                    }
                }
                .padding(viewModel.showingGrid ? 10 : 0)
                .navigationTitle("List of people")
                .toolbar(id: "options") {
                    ToolbarItem(id: "add", placement: .primaryAction) {
                        NavigationLink(destination: {
                            AddPersonView()
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                    ToolbarItem(id: "list", placement: .topBarLeading) {
                        Menu {
                            Button(viewModel.showingGrid ? "Show List" : "Show Grid") {
                                viewModel.showingGrid.toggle()
                            }
                        } label: {
                            Label("Options", systemImage: "ellipsis.circle")
                        }
                    }
                }
            }
            .onAppear {
                viewModel.getPeople()
            }
        }
    }
}

#Preview {
    PeopleListView()
}
