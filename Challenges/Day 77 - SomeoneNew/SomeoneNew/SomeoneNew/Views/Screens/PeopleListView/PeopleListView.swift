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
                if viewModel.people.isEmpty {
                    emptyView
                } else {
                    peopleListView
                }
            } // ZStack
            .navigationTitle("List of people")
            .toolbar(id: "options") {
                ToolbarItem(id: "add", placement: .primaryAction) {
                    NavigationLink(destination: {
                        AddPersonView()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                if !viewModel.people.isEmpty {
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
            } // Toolbar
            .onAppear {
                viewModel.getPeople()
            }
        }
    }

    private var emptyView: some View {
        VStack {
            Text("""
                 There are no people.
                 Tap the '+' icon to add a new person.
                 """)
        }
    }

    private var peopleListView: some View {
        VStack {
            if viewModel.showingGrid {
                GridLayout(people: $viewModel.people)
            } else {
                ListLayout(people: $viewModel.people, onDelete: viewModel.deletePerson)
            }
        } // VStack
        .padding(viewModel.showingGrid ? 10 : 0)
    }
}

#Preview {
    PeopleListView()
}
