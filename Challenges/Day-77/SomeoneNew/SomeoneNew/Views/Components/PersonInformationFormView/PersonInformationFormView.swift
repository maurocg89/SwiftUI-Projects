//
//  PersonInformationFormView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 28/11/2023.
//

import SwiftUI

struct PersonInformationFormView: View {
    @Environment(\.dismiss) var dismiss
    var isDetailView: Bool
    @Binding var inputImage: UIImage?
    @Binding var newPersonName: String
    @Binding var newPersonLastName: String
    @Binding var newPersonDescription: String
    @Binding var showAddImageSheet: Bool
    var buttonAction: (() -> Void)?

    var body: some View {
        ZStack {
            backgroundColor()
            VStack {
                ZStack {
                    if inputImage != nil {
                        Image(uiImage: inputImage!)
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
                    showAddImageSheet = true
                }

                Form {
                    Section {
                        TextField("Name", text: $newPersonName)
                        TextField("Last Name", text: $newPersonLastName)
                    } header: {
                        Text("Person Information")
                    }

                    Section {
                        TextField("Description", text: $newPersonDescription, axis: .vertical)
                            .lineLimit(5...)

                    } header: {
                        Text("Description")
                    }

                    if !isDetailView {
                        Section {
                            Button("Add person") {
                                buttonAction?()
                                dismiss()
                            }
                            .disabled(!isFormValid())
                        }
                    }
                }
                .scrollDisabled(true)
                .frame(maxHeight: .infinity)
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)

                Spacer()
            }
            .sheet(isPresented: $showAddImageSheet, content: {
                ImagePicker(image: $inputImage)
            })
        }
        .toolbar(content: {
            if isDetailView {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        buttonAction?()
                        dismiss()
                    }
                    .disabled(!isFormValid())
                }
            }
        })
    }

    func isFormValid() -> Bool {
        return !newPersonName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !newPersonLastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && inputImage != nil
    }
}

#Preview {
    PersonInformationFormView(isDetailView: false, inputImage: .constant(nil), newPersonName: .constant(""), newPersonLastName: .constant(""), newPersonDescription: .constant(""), showAddImageSheet: .constant(false), buttonAction: {})
}