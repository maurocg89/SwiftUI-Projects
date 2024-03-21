//
//  RequestAppStoreReview.swift
//  Instafilter
//
//  Created by Mauro Grillo on 08/02/2024.
//

import StoreKit
import SwiftUI

struct RequestAppStoreReview: View {
    @Environment(\.requestReview) var requestReview

    var body: some View {
        Text("Hello, World!")
            .onAppear {
                requestReview()
            }
    }
}

#Preview {
    RequestAppStoreReview()
}
