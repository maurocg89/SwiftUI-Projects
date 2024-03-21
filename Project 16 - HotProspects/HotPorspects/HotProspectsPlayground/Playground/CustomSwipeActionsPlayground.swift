//
//  CustomSwipeActionsPlayground.swift
//  HotPorspects
//
//  Created by Mauro Grillo on 02/01/2024.
//

import SwiftUI

struct CustomSwipeActionsPlayground: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button {
                        print("Hi")
                    } label: {
                        Label("Send message", systemImage: "message")
                    }
                }

            Text("Paul Hudson")
                .swipeActions {
                    Button(role: .destructive) {
                        print("Deleting")
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("pinning")
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(.orange)
                }
        }
    }
}

#Preview {
    CustomSwipeActionsPlayground()
}
