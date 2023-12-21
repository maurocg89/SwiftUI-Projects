//
//  Binding+Extension.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 21/12/2023.
//

import SwiftUI

extension Binding {
    func withDefault<Wrapped>(value defaultValue: Wrapped) -> Binding<Wrapped> where Optional<Wrapped> == Value {
        Binding<Wrapped> {
            wrappedValue ?? defaultValue
        } set: { newValue in
            self.wrappedValue = newValue
        }
    }
}
