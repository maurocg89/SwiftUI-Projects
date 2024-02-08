//
//  PhotosPickerPlayground.swift
//  Instafilter
//
//  Created by Mauro Grillo on 08/02/2024.
//

import PhotosUI
import SwiftUI

struct PhotosPickerPlayground: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    // Multiple selection
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()

    var body: some View {
        VStack {
//            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
//
//            selectedImage?
//                .resizable()
//                .scaledToFit()
            
            // Multiple selection
//            PhotosPicker("Select pictures", selection: $pickerItems, maxSelectionCount: 4, matching: .images)

            // With Custom Label
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 4, matching: .any(of: [.images, .not(.screenshots)])) {
                Label("Select pictures", systemImage: "photo")
            }

            ScrollView {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerItem) { _ in
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
        .onChange(of: pickerItems) { _ in
            Task {
                selectedImages.removeAll()
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}

#Preview {
    PhotosPickerPlayground()
}
