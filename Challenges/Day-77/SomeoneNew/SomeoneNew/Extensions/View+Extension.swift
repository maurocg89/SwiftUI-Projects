//
//  View+Extension.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 28/11/2023.
//
import SwiftUI

extension View {
    
    func backgroundColor() -> some View {
        return Color.backgroundColor
            .ignoresSafeArea()
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
