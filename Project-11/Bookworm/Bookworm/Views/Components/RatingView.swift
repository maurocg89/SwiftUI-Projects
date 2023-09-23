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
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
//                    .accessibilityLabel("\(number == 1 ? "1 star" : "\(number) stars")")
//                    .accessibilityRemoveTraits(.isImage)
//                    .accessibilityAddTraits(number > rating ? .isButton : [.isButton, .isSelected])
            }
        }
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

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
