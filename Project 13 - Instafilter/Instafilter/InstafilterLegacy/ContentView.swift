//
//  ContentView.swift
//  Instafilter
//
//  Created by Mauro Grillo on 28/07/2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var radiusFilter = 0.5
    @State private var scaleFilter = 0.5
    @State private var showIntensitySlider = true
    @State private var showRadiusSlider = true
    @State private var showScaleSlider = true
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()

    @State private var showingFilterSheet = false

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)

                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)

                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }

                if image != nil {
                    Text("Current Filter: \(currentFilter.name)")
                        .padding(.vertical)
                }

                if showIntensitySlider {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity) { _ in
                                applyProcessing()
                            }
                    }
                    .padding(.vertical)
                }

                if showRadiusSlider {
                    HStack {
                        Text("Radius")
                        Slider(value: $radiusFilter)
                            .onChange(of: radiusFilter) { _ in
                                applyProcessing()
                            }
                    }
                    .padding(.bottom)
                }

                if showScaleSlider {
                    HStack {
                        Text("Scale")
                        Slider(value: $scaleFilter)
                            .onChange(of: scaleFilter) { _ in
                                applyProcessing()
                            }
                    }
                    .padding(.bottom)
                }

                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }
                    .disabled(buttonDisabled)

                    Spacer()

                    Button("Save", action: save)
                        .disabled(buttonDisabled)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in
                loadImage()
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setFilter(.crystallize()) }
                Button("Edges") { setFilter(.edges()) }
                Button("Gaussian Blur") { setFilter(.gaussianBlur()) }
                Button("Pixellate") { setFilter(.pixellate()) }
                Button("Sepia Tone") { setFilter(.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(.unsharpMask()) }
                Button("Vignette") { setFilter(.vignette()) }
                Group {
                    Button("Color Clamp") { setFilter(.colorClamp()) }
                    Button("Comic Effect") { setFilter(.comicEffect()) }
                    Button("Exposure Adjust") { setFilter(.exposureAdjust()) }
                    Button("Cancel", role: .cancel) { }
                }
            }
        }
    }
    var buttonDisabled: Bool {
        image == nil
    }
    func loadImage() {
        guard let inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func save() {
        guard let processedImage else { return }

        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Success!")
        }
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
            showIntensitySlider = true
        } else {
            showIntensitySlider = false
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(radiusFilter * 200, forKey: kCIInputRadiusKey)
            showRadiusSlider = true
        } else {
            showRadiusSlider = false
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(scaleFilter * 10, forKey: kCIInputScaleKey)
            showScaleSlider = true
        } else {
            showScaleSlider = false
        }
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}
