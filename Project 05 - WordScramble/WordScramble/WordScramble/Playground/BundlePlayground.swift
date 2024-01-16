//
//  BundlePlayground.swift
//  WordScramble
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct BundlePlayground: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func loadFile() {
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                print(fileContents)
            }
        }
    }
}

struct BundlePlayground_Previews: PreviewProvider {
    static var previews: some View {
        BundlePlayground()
    }
}
