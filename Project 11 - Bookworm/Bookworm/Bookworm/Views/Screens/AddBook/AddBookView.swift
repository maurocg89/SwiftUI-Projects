//
//  AddBookView.swift
//  Bookworm
//
//  Created by Mauro Grillo on 09/02/2024.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title of the book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }

                Section {
                    Button("Save") {
                        let bookTitle = title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Unknown Title" : title
                        let bookAuthor = author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Unknown Author" : author
                        let bookGenre = genre
                        let bookRating = rating
                        let bookReview = review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Empty Review" : review

                        let newBook = BookModel(title: bookTitle, author: bookAuthor, genre: bookGenre, review: bookReview, rating: bookRating, date: Date.now)
                        modelContext.insert(newBook)

                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
