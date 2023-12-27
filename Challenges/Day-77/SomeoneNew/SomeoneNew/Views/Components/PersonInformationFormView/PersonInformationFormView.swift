//
//  PersonInformationFormView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 28/11/2023.
//

import SwiftUI
import PhotosUI

enum PersonInformationMode {
    case edit
    case detail
    case add
}

struct PersonInformationFormView: View {
    @Environment(\.dismiss) var dismiss
    var mode: PersonInformationMode
    @Binding var inputImage: UIImage?
    @Binding var person: Person
    @Binding var showAddImageSheet: Bool
    @State var showPickerDialogOptions = false
    @State var pickerType: UIImagePickerController.SourceType = .photoLibrary
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
                } // ZStack
                .frame(width: 140, height: 140, alignment: .center)
                .onTapGesture {
                    showPickerDialogOptions = true
                }

                Form {
                    Section {
                        TextField("Name", text: $person.name)
                        TextField("Last Name", text: $person.lastName)
                    } header: {
                        Text("Person Information")
                    }
                    .submitLabel(.done)

                    Section {
                        TextField("Description", text: $person.description, axis: .vertical)
                            .lineLimit(5...)

                    } header: {
                        Text("Description")
                    }
                }
                .scrollDisabled(true)
                .frame(maxHeight: .infinity)
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)

                Spacer()
            } // VStack
            .onTapGesture {
                self.hideKeyboard()
            }
            .confirmationDialog("", isPresented: $showPickerDialogOptions, titleVisibility: .hidden, actions: {
                Button("Camera") {
                    pickerType = .camera
                    showAddImageSheet.toggle()
                }

                Button("Photo Library") {
                    pickerType = .photoLibrary
                    showAddImageSheet.toggle()
                }
            })
            .fullScreenCover(isPresented: $showAddImageSheet, content: {
                if pickerType == .photoLibrary {
                    ImagePicker(image: $inputImage)
                } else {
                    AccessCameraView(image: $inputImage)
                }
            })
        }
    }
}

#Preview {
    PersonInformationFormView(mode: .detail, inputImage: .constant(nil), person: .constant(Person.example), showAddImageSheet: .constant(false), buttonAction: {})
}
