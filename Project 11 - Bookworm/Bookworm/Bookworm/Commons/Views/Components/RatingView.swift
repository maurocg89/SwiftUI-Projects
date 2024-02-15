//
//  RatingView.swift
//  Bookworm
//
//  Created by Mauro Grillo on 06/07/2023.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int

    var label = ""
    var maxRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow

    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }

            ForEach(1...maxRating, id:\.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
//                    .accessibilityLabel("\(number == 1 ? "1 star" : "\(number) stars")")
//                    .accessibilityRemoveTraits(.isImage)
//                    .accessibilityAddTraits(number > rating ? .isButton : [.isButton, .isSelected])
            }
        } // HStack
        .buttonStyle(.plain) // Because RatingView is inside of a Form, SwiftUI take the row as one button. To fix this we add the plain button style and SwiftUI now treat each button individually inside the row
        .accessibilityElement()
        .accessibilityLabel("Rating")
//        .accessibilityValue(rating == 1 ? "1 Star" : "\(rating) stars")
        .accessibilityValue("^[\(rating) star](inflect: true)")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maxRating { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1 }
            default:
                break
            }
        }

    }

    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
