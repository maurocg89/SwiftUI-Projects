//
//  AddPersonView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 27/10/2023.
//

import SwiftUI

struct AddPersonView: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var pickerTab = 0

    var body: some View {
        ZStack {
            backgroundColor()
            VStack {
                PickerTabView(pickerTabSelection: $pickerTab)
                if pickerTab == 0 {
                    PersonInformationFormView(mode: .add, inputImage: $viewModel.inputImage, person: $viewModel.newPerson, showAddImageSheet: $viewModel.showAddImageSheet, buttonAction: {
                            viewModel.addPerson()
                    })
                } else {
                    MapView(mapRegion: $viewModel.mapRegion, location: $viewModel.newPerson.location.withDefault(value: Location.empty), isDetailView: false, buttonAction: nil)
                }

            } //VStack
            .navigationBarTitleDisplayMode(.inline)
        } // ZStack
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add person") {
                    viewModel.addPerson()
                    dismiss()
                }
                .disabled(!viewModel.isFormValid())
            }
        }
    }
}

#Preview {
    AddPersonView()
}
