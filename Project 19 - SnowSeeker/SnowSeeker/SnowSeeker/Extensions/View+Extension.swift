//
//  View+Extension.swift
//  SnowSeeker
//
//  Created by Mauro Grillo on 23/01/2024.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
