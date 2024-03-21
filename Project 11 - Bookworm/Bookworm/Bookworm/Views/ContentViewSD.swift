//
//  ContentViewSD.swift
//  Bookworm
//
//  Created by Mauro Grillo on 09/02/2024.
//

import SwiftData
import SwiftUI

// ContentView SwiftData
struct ContentViewSD: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\BookModel.title, order: .forward),
        SortDescriptor(\BookModel.author, order: .forward)
    ]) var books: [BookModel]

    @State private var showingAddScreen = false

    var body: some View {
        NavigationStack {
            Group {
                if books.isEmpty {
                    ContentUnavailableView("There are no saved books", systemImage: "book", description: Text("Tap the '+' button to add a new one"))
                } else {
                    List {
                        ForEach(books) { book in
                            NavigationLink(value: book) {
                                HStack {
                                    EmojiRatingView(rating: book.rating)
                                        .font(.largeTitle)

                                    VStack(alignment: .leading) {
                                        Text(book.title)
                                            .font(.headline)
                                            .foregroundStyle(book.rating == 1 ? Color.red : Color.black)

                                        Text(book.author)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteBooks(at:))
                    }
                }
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: BookModel.self, destination: { book in
                DetailView(book: book)
            })
            .toolbar {
                if !books.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }

    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentViewSD()
}
