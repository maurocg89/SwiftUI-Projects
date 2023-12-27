//
//  ImagePicker.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 15/10/2023.
//

import PhotosUI
import SwiftUI

protocol CameraAndLibraryPicker {
    var imageBinding: UIImage? { get set }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension ImagePicker: CameraAndLibraryPicker {
    var imageBinding: UIImage? {
        get {
            image!
        }
        set {
            image = newValue
        }
    }
}

struct AccessCameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var isPresented

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

extension AccessCameraView: CameraAndLibraryPicker {
    var imageBinding: UIImage? {
        get {
            image!
        }
        set {
            image = newValue
        }
    }
}

// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate, UIImagePickerControllerDelegate {
    var parent: CameraAndLibraryPicker

    init(_ parent: CameraAndLibraryPicker) {
        self.parent = parent
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let provider = results.first?.itemProvider else { return }

        if provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    if let parent = self.parent as? ImagePicker {
                        parent.image = image as? UIImage
                    }
//                    self.parent.imageBinding = image as? UIImage
                }
            }
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        DispatchQueue.main.async {
            if let parent = self.parent as? AccessCameraView {
                parent.image = selectedImage
                parent.isPresented.wrappedValue.dismiss()
//                self.parent.imageBinding = selectedImage
            }
        }
    }
}
