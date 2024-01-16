//
//  LocationButton.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 19/12/2023.
//

import SwiftUI

struct LocationButton: View {
    var title: String
    var action: (() -> Void)?

    var body: some View {
        Button {
            action?()
        } label: {
            Label("\(title)", systemImage: "location")
                .labelStyle(.titleAndIcon)
        }
        .buttonStyle(.borderedProminent)
    }
}
