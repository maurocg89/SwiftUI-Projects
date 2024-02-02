//
//  CustomTransitionViewPlayground.swift
//  Animations
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct CustomTransitionViewPlayground: View {
    @State private var isShowingRed = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
        
    }
}

struct CustomTransitionViewPlayground_Previews: PreviewProvider {
    static var previews: some View {
        CustomTransitionViewPlayground()
    }
}
