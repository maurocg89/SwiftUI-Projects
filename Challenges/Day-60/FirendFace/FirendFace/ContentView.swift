//
//  ContentView.swift
//  FirendFace
//
//  Created by Mauro Grillo on 20/07/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        NavigationView {
            UserListView()
                .environment(\.managedObjectContext, moc)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
