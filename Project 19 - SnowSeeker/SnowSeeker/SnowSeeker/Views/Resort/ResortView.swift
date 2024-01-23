//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Mauro Grillo on 23/01/2024.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()

                HStack {
                    ResortDetailsView(resort: resort)
                    SkiDetailsView(resort: resort)
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))

                Group {
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)

                    Text(resort.facilities, format: .list(type: .and))
                        .padding(.vertical)
                } // Group
                .padding(.horizontal)
            } // VStack
            .navigationTitle("\(resort.name), \(resort.country)")
            .navigationBarTitleDisplayMode(.inline)
        } // ScrollView
    }
}

#Preview {
    ResortView(resort: Resort.example)
}
