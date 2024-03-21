//
//  UrlSessionPlaygroundView.swift
//  CupcakeCorner
//
//  Created by Mauro Grillo on 30/06/2023.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct UrlSessionPlaygroundView: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }

    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid url")
            return
        }

        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                self.results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }

    }
}

#Preview {
    UrlSessionPlaygroundView()
}
