//
//  ShowHideViewPlayground.swift
//  Animations
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct ShowHideViewPlayground: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap Me (Show Hide)") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct ShowHideViewPlayground_Previews: PreviewProvider {
    static var previews: some View {
        ShowHideViewPlayground()
    }
}
