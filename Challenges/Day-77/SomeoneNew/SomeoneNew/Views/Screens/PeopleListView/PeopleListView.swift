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
                    GridLayout(people: $viewModel.people)
                        .padding(.vertical)
                        .navigationTitle("List of people")
                        .toolbar(content: {
                            NavigationLink(destination: {
                                AddPersonView()
                            }, label: {
                                Image(systemName: "plus")
                            })
                        })
                    Button("Reset Data", role: .destructive) {
                        viewModel.resetData()
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
