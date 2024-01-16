//
//  View+Extension.swift
//  Flashzilla
//
//  Created by Mauro Grillo on 05/01/2024.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
