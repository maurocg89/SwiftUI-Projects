//
//  ImagePickerPlaygroundView.swift
//  Instafilter
//
//  Created by Mauro Grillo on 10/08/2023.
//

import SwiftUI

struct ImagePickerPlaygroundView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                showingImagePicker = true
            }
            .padding()

            Button("Save Image") {
                if inputImage != nil {
                    saveImage()
                }
            }
            .padding()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in
            loadImage()
        }
    }

    func loadImage() {
        guard let inputImage else { return }
        image = Image(uiImage: inputImage)
    }

    func saveImage() {
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage!)
    }
}

struct ImagePickerPlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerPlaygroundView()
    }
}
