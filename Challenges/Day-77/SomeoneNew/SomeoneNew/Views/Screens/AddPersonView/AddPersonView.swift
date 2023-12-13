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

    var body: some View {
        ZStack {
            backgroundColor()
            PersonInformationFormView(isDetailView: false, inputImage: $viewModel.inputImage, newPersonName: $viewModel.newPersonName, newPersonLastName: $viewModel.newPersonLastName, newPersonDescription: $viewModel.newPersonDescritpion, showAddImageSheet: $viewModel.showAddImageSheet, buttonAction: {
                viewModel.addPerson()
            })
        }
    }
}

#Preview {
    AddPersonView()
}
