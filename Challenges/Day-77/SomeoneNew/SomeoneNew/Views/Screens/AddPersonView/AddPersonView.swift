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
            Color(uiColor: .systemGray6)
                .ignoresSafeArea()
            VStack {
                ZStack {
                    if viewModel.inputImage != nil {
                        Image(uiImage: viewModel.inputImage!)
                            .resizable()
                            .clipShape(Circle())
                            .overlay(
                                Text("Edit")
                                    .background(Color.black.opacity(0.6))
                                    .lineLimit(1)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .clipShape(ContainerRelativeShape()).padding(4)
                                    .minimumScaleFactor(0.1)
                            , alignment: .bottom)
                    } else {
                        Image(systemName: "photo.circle")
                            .resizable()
                            .foregroundStyle(Color.gray)
                            .overlay(
                                Text("Add picture")
                                    .background(Color.gray)
                                    .lineLimit(1)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .clipShape(ContainerRelativeShape()).padding()
                                    .minimumScaleFactor(0.1)
                                , alignment: .bottom)
                    }
                }
                .frame(width: 140, height: 140, alignment: .center)
                .onTapGesture {
                    viewModel.showAddImageSheet = true
                }

                Form {
                    Section {
                        TextField("Name", text: $viewModel.newPersonName)
                        TextField("Last Name", text: $viewModel.newPersonLastName)
                    } header: {
                        Text("Person Information")
                    }

                    Section {
                        Button("Add person") {
                            viewModel.addPerson()
                            dismiss()
                        }
                        .disabled(!viewModel.isFormValid())
                    }
                }
                .scrollDisabled(true)
                .frame(height: 300)
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)

                Spacer()
            }
            .sheet(isPresented: $viewModel.showAddImageSheet, content: {
                ImagePicker(image: $viewModel.inputImage)
            })
//            .onChange(of: viewModel.inputImage) { _ in }
        }

    }
}

#Preview {
    AddPersonView()
}
