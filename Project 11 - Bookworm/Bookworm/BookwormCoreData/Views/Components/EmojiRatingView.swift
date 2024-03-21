//
//  EmojiRatingView.swift
//  BookwormCoreData
//
//  Created by Mauro Grillo on 21/03/2024.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int

    var body: some View {
        switch rating {
        case 1:
            return Text("😩")
        case 2:
            return Text("☹️")
        case 3:
            return Text("🙂")
        case 4:
            return Text("😊")
        default:
            return Text("🤩")
        }
    }
}
#Preview {
    EmojiRatingView(rating: 4)
}

