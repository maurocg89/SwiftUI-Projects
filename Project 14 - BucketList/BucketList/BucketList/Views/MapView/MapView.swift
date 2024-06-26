//
//  MapImprovedAnnotationsPlaygroundView.swift
//  BucketList
//
//  Created by Mauro Grillo on 24/08/2023.
//

import MapKit
import SwiftUI

struct MapView: View {

    @StateObject private var viewModel = ViewModel()

    var body: some View {
        Group {
            if viewModel.isUnlocked {
                ZStack {
                    Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            VStack {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 44, height: 44) // Recommended minimum size for any interactive elements in the ui
                                    .background(.white)
                                    .clipShape(Circle())

                                Text(location.name)
                                    .fixedSize()
                            }
                            .onTapGesture {
                                viewModel.selectedPlace = location
                            }
                        }
                    }
                    .ignoresSafeArea()

                    Circle()
                        .fill(.blue)
                        .opacity(0.3)
                        .frame(width: 32, height: 32)

                    VStack {
                        Spacer()

                        HStack {
                            Spacer()

                            Button {
                                viewModel.addLocation()
                            } label: {
                                Image(systemName: "plus")
                                    .padding()
                                    .background(.black.opacity(0.75))
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .clipShape(Circle())
                                    .padding(.trailing)
                            }
                        }
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    LocationEditView(location: place) { newLocation in
                        viewModel.update(location: newLocation)
                    } onDelete: { locationToDelete in
                        viewModel.delete(location: locationToDelete)
                    }
                }
            } else {
                Button("Unlock Places") {
                    viewModel.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
