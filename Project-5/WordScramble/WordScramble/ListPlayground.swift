//
//  ListPlayground.swift
//  WordScramble
//
//  Created by Mauro Grillo on 31/05/2023.
//

import SwiftUI

struct ListPlayground: View {
    
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        VStack(spacing: 20) {
            List {
                Section("Section 1") {
                    Text("Static row 1")
                    Text("Static row 2")
                }
                
                Section("Section 2") {
                    ForEach(0..<5) {
                        Text("Dynamic row \($0)")
                    }
                }
                
                Section("Section 3") {
                    Text("Static row 3")
                    Text("Static row 4")
                }
            }
            .listStyle(.grouped)
            
            List(0..<5) {
                Text("Dynamic row \($0)")
            }
            .listStyle(.grouped)
            
            List(people, id: \.self) {
                Text($0)
            }
            .listStyle(.grouped)
            
            List {
                ForEach(people, id: \.self) {
                    Text($0)
                }
            }
            .listStyle(.grouped)
        }
    }
}

struct ListPlayground_Previews: PreviewProvider {
    static var previews: some View {
        ListPlayground()
    }
}
