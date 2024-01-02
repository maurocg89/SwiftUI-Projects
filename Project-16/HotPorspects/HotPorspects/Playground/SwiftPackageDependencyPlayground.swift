//
//  SwiftPackageDependencyPlayground.swift
//  HotPorspects
//
//  Created by Mauro Grillo on 02/01/2024.
//

import SamplePackage
import SwiftUI

struct SwiftPackageDependencyPlayground: View {
    let posibleNumbers = Array(1...60)

    var body: some View {
        Text(results)
    }

    var results: String {
        let selected = posibleNumbers.random(7).sorted() // random method from SamplePackage
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
}

#Preview {
    SwiftPackageDependencyPlayground()
}
