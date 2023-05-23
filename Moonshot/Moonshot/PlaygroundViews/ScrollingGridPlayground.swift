//
//  ScrollingGridPlayground.swift
//  Moonshot
//
//  Created by Mauro Grillo on 19/05/2023.
//

import SwiftUI

struct ScrollingGridPlayground: View {
    let layoutFixed = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    
    let layoutAdaptative = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layoutAdaptative) {
                ForEach(0..<100) {
                    Text("ITEM \($0)")
                }
            }
        }
        
//        ScrollView(.horizontal) {
//            LazyHGrid(rows: layoutAdaptative) {
//                ForEach(0..<100) {
//                    Text("ITEM \($0)")
//                }
//            }
//        }
    }
}

struct ScrollingGridPlayground_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingGridPlayground()
    }
}
