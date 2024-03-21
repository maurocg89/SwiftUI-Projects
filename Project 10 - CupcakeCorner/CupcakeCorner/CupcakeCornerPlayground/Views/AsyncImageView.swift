//
//  AsyncImageView.swift
//  CupcakeCorner
//
//  Created by Mauro Grillo on 30/06/2023.
//

import SwiftUI

struct AsyncImageView: View {
    var body: some View {
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
//            image
//                .resizable()
//                .scaledToFit()
//        } placeholder: {
//            ProgressView()
//        }
//        .frame(width: 200, height: 200)

        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    AsyncImageView()
}
