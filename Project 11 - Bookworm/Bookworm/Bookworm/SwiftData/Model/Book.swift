//
//  Book.swift
//  Bookworm
//
//  Created by Mauro Grillo on 09/02/2024.
//

import Foundation
import SwiftData

@Model
class BookModel {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date: Date

    init(title: String, author: String, genre: String, review: String, rating: Int, date: Date) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }

}
