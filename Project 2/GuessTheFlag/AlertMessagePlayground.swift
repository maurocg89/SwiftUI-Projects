//
//  AlertMessagePlayground.swift
//  GuessTheFlag
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct AlertMessagePlayground: View {
    @State private var showingAlert = false

    var body: some View {
        VStack(spacing: 20) {
            Button("Show Alert") {
                showingAlert = true
            }
            .alert("Important message", isPresented: $showingAlert) {
                Button("Delete", role: .destructive) { }
                Button("Cancel", role: .cancel) { }
            }
            
            Button("Show Alert") {
                showingAlert = true
            }
            .alert("Important message", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please read this.")
            }
        }
    }
}

struct AlertMessagePlayground_Previews: PreviewProvider {
    static var previews: some View {
        AlertMessagePlayground()
    }
}
