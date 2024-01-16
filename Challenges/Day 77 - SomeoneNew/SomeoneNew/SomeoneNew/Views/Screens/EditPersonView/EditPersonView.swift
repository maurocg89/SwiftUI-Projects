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
                PickerTabView(pickerTabSelection: $pickerTab)

                if pickerTab == 0 {
                    PersonInformationFormView(mode: .edit, inputImage: $viewModel.inputImage, person: $viewModel.selectedPerson, showAddImageSheet: $viewModel.showAddImageSheet, buttonAction: {})
                } else {
                    MapView(mapRegion: $viewModel.mapRegion, location: $viewModel.selectedPerson.location.withDefault(value: Location.empty), isDetailView: false, buttonAction: nil)
                }
            } // VStack
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        viewModel.updatePerson()
                        dismiss()
                    }
                    .disabled(!viewModel.isFormValid())
                }
            })
        } // ZStack
    }
}

#Preview {
    EditPersonView(viewModel: .init(selectedPerson: Person.example))
}
