//
//  PersonDetailView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 17/10/2023.
//

import SwiftUI

struct PersonDetailView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var pickerTab = 0
    @State private var openFullImage = false
    var selectedPersonId: UUID

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor()
                VStack {
                    PickerTabView(pickerTabSelection: $pickerTab)
                    
                    if pickerTab == 0 {
                        detailView
                    } else {
                        mapView
                    }

                    Spacer()
                } // VStack
                .toolbar(content: {
                    NavigationLink(destination: {
                        EditPersonView(viewModel: .init(selectedPerson: viewModel.selectedPerson))
                    }, label: {
                        Text("Edit")
                    })
                })
                .navigationBarTitleDisplayMode(.inline)

                if openFullImage {
                    fullImageView
                }

            } // ZStack
            .onAppear {
                viewModel.getPersonUpdated(selectedPersonId)
                openFullImage = false
            }
        }
    }

    private var detailView: some View {
        VStack {
            imageSection

            Text("\(viewModel.selectedPerson.name) \(viewModel.selectedPerson.lastName)" )
                .font(.title)
                .bold()

            Form {
                Section("Description") {
                    TextField("", text: $viewModel.selectedPerson.description, axis: .vertical)
                        .lineLimit(5...)
                        .disabled(true)
                }
            }
            .scrollDisabled(true)
        }
    }

    private var imageSection: some View {
        Group {
            if viewModel.selectedPerson.image != nil {
                Image(uiImage: viewModel.selectedPerson.image!)
                    .resizable()
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundStyle(Color.black
                        .opacity(0.7))
            }
        }
        .frame(width: 140, height: 140, alignment: .top)
        .onTapGesture {
            withAnimation {
                openFullImage = true
            }
        }
    }

    @ViewBuilder
    private var mapView: some View {
        if viewModel.selectedPerson.location != nil {
            MapView(mapRegion: $viewModel.mapRegion, location: $viewModel.selectedPersonLocation, isDetailView: true, buttonAction: nil)
        } else {
            Text("There is no location")
        }
    }

    private var fullImageView: some View {
        ZStack {
            Color(.white)
            if viewModel.selectedPerson.image != nil {
                Image(uiImage: viewModel.selectedPerson.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            openFullImage.toggle()
        }
    }
}

#Preview {
    PersonDetailView(selectedPersonId: Person.example.id)
}
