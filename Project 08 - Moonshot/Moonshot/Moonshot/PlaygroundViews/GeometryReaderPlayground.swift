//
//  GeometryReaderPlayground.swift
//  Moonshot
//
//  Created by Mauro Grillo on 19/05/2023.
//

import SwiftUI

struct GeometryReaderPlayground: View {
    var body: some View {
        GeometryReader { geo in
            Image("Example")
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width * 0.8)
                .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    GeometryReaderPlayground()
}
