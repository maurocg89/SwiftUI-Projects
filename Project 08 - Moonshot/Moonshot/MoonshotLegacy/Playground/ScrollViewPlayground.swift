//
//  ScrollViewPlayground.swift
//  Moonshot
//
//  Created by Mauro Grillo on 19/05/2023.
//

import SwiftUI

struct ScrollViewPlayground: View {
    
    var body: some View {
        ScrollView {
            // With lazy VStack creates only the amount of texts that appear in the screen
            // With regular VStack creates all of the for each texts at once
            // LazyVStack takes all the available free space of the layout, where regular VStack only take up as much space as needed for their children
            LazyVStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText: \(text)")
        self.text = text
    }
}
#Preview {
    ScrollViewPlayground()
}
