//
//  PersonDetailView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 17/10/2023.
//

import SwiftUI

struct PersonDetailView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var pickerTab = 0
    var selectedPersonId: UUID

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor()
                VStack {
                    Picker("", selection: $pickerTab) {
                        Text("Detail").tag(0)
                        Text("Event Location").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    if pickerTab == 0 {
                        detailView
                    } else {
                        if viewModel.selectedPerson.location != nil {
                            MapView(mapRegion: $viewModel.mapRegion, location: $viewModel.selectedPersonLocation, newLocationName: $viewModel.newLocationName, isDetailView: true, buttonAction: nil)
                        } else {
                            Text("There is no location")
                        }
                    }

                    Spacer()
                }
                .toolbar(content: {
                    NavigationLink(destination: {
                        EditPersonView(selectedPersonId: viewModel.selectedPerson.id)
                    }, label: {
                        Text("Edit")
                    })
                })
            }
            .onAppear {
                viewModel.getPersonUpdated(selectedPersonId)
            }
        }
    }

    private var detailView: some View {
        VStack {
            Group {
                if viewModel.selectedPerson.image != nil {
                    Image(uiImage: viewModel.selectedPerson.image!)
                        .resizable()
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .foregroundStyle(Color.black
                            .opacity(0.7))
                }
            }
            .frame(width: 140, height: 140, alignment: .top)

            Text("\(viewModel.selectedPerson.name) \(viewModel.selectedPerson.lastName)" )
                .font(.title)
                .bold()

            Form {
                Section("Description") {
                    TextField("", text: $viewModel.selectedPerson.description, axis: .vertical)
                        .lineLimit(5...)
                        .disabled(true)
                }
            }
            .scrollDisabled(true)
        }
    }
}

#Preview {
    PersonDetailView(selectedPersonId: Person.example.id)
}
