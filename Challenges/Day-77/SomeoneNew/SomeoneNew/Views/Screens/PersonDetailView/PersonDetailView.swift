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
                    PickerTabView(pickerTabSelection: $pickerTab)
                    
                    if pickerTab == 0 {
                        detailView
                    } else {
                        mapView
                    }

                    Spacer()
                } // VStack
                .toolbar(content: {
                    NavigationLink(destination: {
                        EditPersonView(viewModel: .init(selectedPerson: viewModel.selectedPerson))
                    }, label: {
                        Text("Edit")
                    })
                })
                .navigationBarTitleDisplayMode(.inline)
            } // ZStack
            .onAppear {
                viewModel.getPersonUpdated(selectedPersonId)
            }
        }
    }

    private var detailView: some View {
        VStack {
            imageSection

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

    private var imageSection: some View {
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
    }

    @ViewBuilder
    private var mapView: some View {
        if viewModel.selectedPerson.location != nil {
            MapView(mapRegion: $viewModel.mapRegion, location: $viewModel.selectedPersonLocation, isDetailView: true, buttonAction: nil)
        } else {
            Text("There is no location")
        }
    }
}

#Preview {
    PersonDetailView(selectedPersonId: Person.example.id)
}
