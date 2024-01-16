//
//  PickerTabView.swift
//  SomeoneNew
//
//  Created by Mauro Grillo on 21/12/2023.
//

import SwiftUI

struct PickerTabView: View {
    @Binding var pickerTabSelection: Int

    var body: some View {
        Picker("", selection: $pickerTabSelection) {
            Text("Detail").tag(0)
            Text("Event Location").tag(1)
        }
        .pickerStyle(.segmented)
        .padding()
    }
}

#Preview {
    PickerTabView(pickerTabSelection: .constant(0))
}
