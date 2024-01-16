//
//  LocationEditPlaygroundView.swift
//  BucketList
//
//  Created by Mauro Grillo on 24/08/2023.
//

import SwiftUI

struct LocationEditView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ViewModel
    var onSave: (Location) -> Void
    var onDelete: (Location) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }

                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            /*@START_MENU_TOKEN@*/Text(page.title)/*@END_MENU_TOKEN@*/
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Menu {
                    Button("Save") {
                        var newLocation = viewModel.location
                        newLocation.id = UUID()
                        newLocation.name = viewModel.name
                        newLocation.description = viewModel.description
                        onSave(newLocation)
                        dismiss()
                    }
                    Button(role: .destructive) {
                        onDelete(viewModel.location)
                        dismiss()
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Label("Menu", systemImage: "ellipsis.circle")
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }

    // @escaping means the function is being stashed away for user later on, rather than being called immediately, and it’s needed here because the onSave function will get called only when the user presses Save.
//    init(location: Location, onSave: @escaping (Location) -> Void) {
//        self.location = location
//        self.onSave = onSave
//
//        _name = State(initialValue: location.name)
//        _description = State(initialValue: location.description)
//    }

    init(location: Location, onSave: @escaping (Location) -> Void, onDelete: @escaping (Location) -> Void) {
        self._viewModel = StateObject(wrappedValue: ViewModel(location: location))
        self.onSave = onSave
        self.onDelete = onDelete
    }
}

struct LocationEditView_Previews: PreviewProvider {
    static var previews: some View {
        LocationEditView(location: Location.example, onSave: {_ in }) { _ in }
    }
}
