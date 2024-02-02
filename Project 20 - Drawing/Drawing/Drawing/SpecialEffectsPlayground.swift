//
//  SpecialEffectsPlayground.swift
//  Drawing
//
//  Created by Mauro Grillo on 30/05/2023.
//

import SwiftUI

struct SpecialEffectsPlayground: View {
    @State private var amount = 0.0
    
    var body: some View {
        BlurPlayground()
//        VStack {
//            ZStack {
//                Circle()
//                    .fill(Color(red: 1, green: 0, blue: 0))
//                    .frame(width: 200 * amount)
//                    .offset(x: -50, y: -80)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(Color(red: 0, green: 1, blue: 0))
//                    .frame(width: 200 * amount)
//                    .offset(x: 50, y: -80)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(Color(red: 0, green: 0, blue: 1))
//                    .frame(width: 200 * amount)
//                    .blendMode(.screen)
//            }
//            .frame(width: 300, height: 300)
//
//            Slider(value: $amount)
//                .padding()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.black)
//        .ignoresSafeArea()
//        ZStack {
//            Image("Example2")
//                .colorMultiply(.red)
//
////            Rectangle()
////                .fill(.red)
////                .blendMode(.multiply)
//        }
    }
}

struct BlurPlayground: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            Image("Example2")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

struct SpecialEffectsPlayground_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffectsPlayground()
    }
}
