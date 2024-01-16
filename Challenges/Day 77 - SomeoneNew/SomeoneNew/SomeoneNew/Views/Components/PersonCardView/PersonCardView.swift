//
//  PersonCardView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 17/10/2023.
//

import SwiftUI

struct PersonCardView: View {
    @Binding var person: Person
    var showingGrid: Bool

    var body: some View {
        if showingGrid {
            gridCardView
        } else {
            listCardView
        }
    }

    private var gridCardView: some View {
        VStack {
            if let image = person.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()
                    .tint(.black)
            }

            Text("\(person.name) \(person.lastName)")
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.bottom)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(red: 0.2, green: 0.2, blue: 0.3))
        }
    }

    private var listCardView: some View {
        HStack {
            Group {
                if let image = person.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()
                        .tint(.black)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))

            Text("\(person.name) \(person.lastName)")
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
//        .overlay {
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color(red: 0.2, green: 0.2, blue: 0.3))
//        }
    }

}

#Preview {
    PersonCardView(person: .constant(Person.example), showingGrid: false)
}
