//
//  LocationEditView-ViewModel.swift
//  BucketList
//
//  Created by Mauro Grillo on 09/09/2023.
//

import Foundation

extension LocationEditView {
    enum LoadingState {
        case loading, loaded, failed
    }

    @MainActor class ViewModel: ObservableObject {
        @Published var name = ""
        @Published var description = ""
        @Published private(set) var loadingState = LoadingState.loading
        @Published private(set) var pages = [Page]()
        @Published private(set) var showAlert = false
        @Published private(set) var alertMessage = ""

        var location: Location

        init(location: Location) {
            self.location = location
            self.name = location.name
            self.description = location.description
        }

        func fetchNearbyPlaces() async {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(latitude)%7C\(longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                showAlert = true
                alertMessage = "Bad URL: \(urlString)"
                print("Bad URL: \(urlString)")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }

        }
        
    }
}
