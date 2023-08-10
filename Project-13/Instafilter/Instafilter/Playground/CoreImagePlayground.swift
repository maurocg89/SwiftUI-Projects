//
//  CoreImagePlayground.swift
//  Instafilter
//
//  Created by Mauro Grillo on 10/08/2023.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct CoreImagePlayground: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear {
            loadImage()
        }
    }

    func loadImage() {
        // UIImage
        guard let inputImage = UIImage(named: "Example") else { return }
        // CoreImage
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
        // Filters
        let currentFilter = CIFilter.sepiaTone()
//        let currentFilter2 = CIFilter.pixellate()
//        let currentFilter3 = CIFilter.crystallize()
//        let currentFilter4 = CIFilter.twirlDistortion()

        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 1

//        currentFilter2.inputImage = beginImage
//        currentFilter2.scale = 100

//        currentFilter3.inputImage = beginImage
//        currentFilter3.radius = 200

//        currentFilter4.inputImage = beginImage
//        currentFilter4.radius = 1000
//        currentFilter4.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)

        // For dynamically query filters
        let amount = 1.0
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }

        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }

        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiIamge = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiIamge)
        }
    }
}

struct CoreImagePlayground_Previews: PreviewProvider {
    static var previews: some View {
        CoreImagePlayground()
    }
}
