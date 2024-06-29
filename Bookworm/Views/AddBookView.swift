//
//  AddBookView.swift
//  Bookworm
//
//  Created by Dmitriy Eliseev on 28.06.2024.
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
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "Unknown"]
    
    var date = Date.now
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    Image(genre)
                        .resizable()
                        .scaledToFit()
                }
                Section("Write a review"){
                    TextEditor(text: $review)
                    
                    //                    Picker("Rating", selection: $rating){
                    //                        ForEach(0..<6) {
                    //                            Text(String($0))
                    //                        }
                    //                    }
                    RatingView(rating: $rating)
                }
                
                Section{
                    Text("Curent date: \(ContentView.formatter.string(from: date))")
                    Button("Save"){
                        let newBook = BookOne(title: title, author: author, genre: genre, review: review, rating: rating, date: date)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .disabled(title.isEmpty || author.isEmpty || checkString(text: title) || checkString(text: author))
                }
                
            }
            .navigationTitle("Add book")
        }
    }
    
    private func checkString(text: String) -> Bool {
        var index = 0
        for chr in text {
            if !chr.isWhitespace {
                index += 1
            }
        }
        if index == 0 {
            return true
        }
        return false
    }
    
}

#Preview {
    AddBookView()
}
