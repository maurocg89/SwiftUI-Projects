//
//  PersonDetailView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 17/10/2023.
//

import SwiftUI

struct PersonDetailView: View {
    @StateObject private var viewModel = ViewModel()
    var selectedPersonId: UUID

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor()
                VStack {
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

                    Spacer()
                }
                .toolbar(content: {
                    NavigationLink(destination: {
                        EditPersonView(selectedPersonId: viewModel.selectedPerson.id)
                    }, label: {
                        Text("Edit")
                    })
                })
            }
            .onAppear {
                viewModel.getPersonUpdated(selectedPersonId)
            }
        }
    }
}

#Preview {
    PersonDetailView(selectedPersonId: Person.example.id)
}
