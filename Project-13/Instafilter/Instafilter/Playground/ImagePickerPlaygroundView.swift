//
//  ImagePickerPlaygroundView.swift
//  Instafilter
//
//  Created by Mauro Grillo on 10/08/2023.
//

import SwiftUI

struct ImagePickerPlaygroundView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker()
        }
    }
}

struct ImagePickerPlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerPlaygroundView()
    }
}
