//
//  EditPersonView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 30/11/2023.
//

import SwiftUI

struct EditPersonView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
    @State private var pickerTab = 0

    var body: some View {
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
                    PersonInformationFormView(mode: .edit, inputImage: $viewModel.inputImage, newPersonName: $viewModel.selectedPerson.name, newPersonLastName: $viewModel.selectedPerson.lastName, newPersonDescription: $viewModel.selectedPerson.description, showAddImageSheet: $viewModel.showAddImageSheet, buttonAction: {})
                } else {
                    MapView(mapRegion: $viewModel.mapRegion, location: $viewModel.selectedPerson.location.withDefault(value: Location.empty), isDetailView: false, buttonAction: nil)
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        viewModel.updatePerson()
                        dismiss()
                    }
                    .disabled(!viewModel.isFormValid())
                }
            })
        }
    }
}

#Preview {
    EditPersonView(viewModel: .init(selectedPerson: Person.example))
}
