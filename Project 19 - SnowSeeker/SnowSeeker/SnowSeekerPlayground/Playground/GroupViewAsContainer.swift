//
//  GroupViewAsContainer.swift
//  SnowSeeker
//
//  Created by Mauro Grillo on 23/01/2024.
//

import SwiftUI
// Using groups as transparent layout containers

struct UserView: View {
    var body: some View {
        // This Group doesn't affect any layout, we are using it to apply the font title to all Text inside.
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct GroupViewAsContainer: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var layoutVertically = false

    var body: some View {
//        Group {
//            if layoutVertically {
//                VStack {
//                    UserView()
//                }
//            } else {
//                HStack {
//                    UserView()
//                }
//            }
//        }
//        .onTapGesture {
//            layoutVertically.toggle()
//        }

        // On larger screens, like the iPhone Pro Max, there are 2 size classes: on portrait the 'compact' size is used and in landscape the 'regular' size is used.
        if sizeClass == .compact {
            VStack(content: UserView.init)
        } else {
            HStack(content: UserView.init)
        }
    }
}

#Preview {
    GroupViewAsContainer()
}
