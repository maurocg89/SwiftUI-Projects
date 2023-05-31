//
//  ImagePaintPlayground.swift
//  Drawing
//
//  Created by Mauro Grillo on 30/05/2023.
//

import SwiftUI

struct ImagePaintPlayground: View {
    var body: some View {
        Capsule()
            .strokeBorder(ImagePaint(image: Image("Example2"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.3), lineWidth: 20)
            .frame(width: 300, height: 200)
    }
}

struct ImagePaintPlayground_Previews: PreviewProvider {
    static var previews: some View {
        ImagePaintPlayground()
    }
}
