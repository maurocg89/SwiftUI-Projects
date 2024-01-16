//
//  InitialsCircleView.swift
//  FirendFace
//
//  Created by Mauro Grillo on 21/07/2023.
//

import SwiftUI

struct InitialsCircleView: View {
    let initials: String
    let isActive: Bool

    var body: some View {
        ZStack(alignment: .center) {
            LinearGradient(colors: [Color(.gray), Color(.lightGray)], startPoint: .top, endPoint: .bottom)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(isActive ? Color.green : Color.gray, lineWidth: 2)
                )

            Text(initials)
                .font(.headline)
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
    }
}

struct InitialsCircleView_Previews: PreviewProvider {
    static var previews: some View {
        InitialsCircleView(initials: "MG", isActive: false)
    }
}
