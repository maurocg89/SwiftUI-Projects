//
//  ShareLinkPlayground.swift
//  Instafilter
//
//  Created by Mauro Grillo on 08/02/2024.
//

import SwiftUI

struct ShareLinkPlayground: View {
    var body: some View {
        // Subject and message depends on the app that is choose to open the item
        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!, subject: Text("Learn Swift Here"), message: Text("Check out the 100 Days of SwiftUI"))

        // Custom Label
        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
            Label("Spread the word about Swift", systemImage: "swift")
        }
        .padding()

        // Share Image
        let example = Image(.example)
        ShareLink(item: example, preview: SharePreview("Singapore Airport", image: example))
    }
}

#Preview {
    ShareLinkPlayground()
}
