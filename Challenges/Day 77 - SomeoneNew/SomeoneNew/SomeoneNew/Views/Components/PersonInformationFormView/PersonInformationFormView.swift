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
                circleImageSection

                formSection

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

    private var circleImageSection: some View {
        VStack {
            circleImageView
                .frame(width: 140, height: 140, alignment: .center)
            
            Button(inputImage == nil ? "Add picture" : "Change") {
                showPickerDialogOptions = true
            }
        } // VStack
        .onTapGesture {
            showPickerDialogOptions = true
        }
    }

    @ViewBuilder
    private var circleImageView: some View {
        if inputImage != nil {
            Image(uiImage: inputImage!)
                .resizable()
                .clipShape(Circle())
        } else {
            Image(systemName: "photo.circle")
                .resizable()
                .foregroundStyle(Color(uiColor: .lightGray))
        }
    }

    private var formSection: some View {
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
        } // Form
        .scrollDisabled(true)
        .frame(maxHeight: .infinity)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PersonInformationFormView(mode: .detail, inputImage: .constant(nil), person: .constant(Person.example), showAddImageSheet: .constant(false), buttonAction: {})
}
