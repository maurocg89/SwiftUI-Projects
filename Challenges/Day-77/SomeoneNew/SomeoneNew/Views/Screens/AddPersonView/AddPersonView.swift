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
                    PersonInformationFormView(mode: .add, inputImage: $viewModel.inputImage, newPersonName: $viewModel.newPerson.name, newPersonLastName: $viewModel.newPerson.lastName, newPersonDescription: $viewModel.newPerson.description, showAddImageSheet: $viewModel.showAddImageSheet, buttonAction: {
                        viewModel.addPerson()
                    })
                } else {
                    MapView(mapRegion: $viewModel.mapRegion, location: $viewModel.newPerson.location.withDefault(value: Location.empty), isDetailView: false, buttonAction: nil)
                }

            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddPersonView()
}
