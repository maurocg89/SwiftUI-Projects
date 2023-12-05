//
//  EditPersonView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 30/11/2023.
//

import SwiftUI

struct EditPersonView: View {
    @StateObject private var viewModel = ViewModel()
    var selectedPersonId: UUID

    var body: some View {
        ZStack {
            backgroundColor()
            PersonInformationFormView(isDetailView: true, inputImage: $viewModel.inputImage, newPersonName: $viewModel.selectedPerson.name, newPersonLastName: $viewModel.selectedPerson.lastName, showAddImageSheet: $viewModel.showAddImageSheet, buttonAction: {
                viewModel.updatePerson()
            })
        }
        .onAppear {
            viewModel.getPersonById(selectedPersonId)
        }
    }
}

#Preview {
    EditPersonView(selectedPersonId: Person.example.id)
}
