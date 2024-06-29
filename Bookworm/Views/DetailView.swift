//
//  DetailView.swift
//  Bookworm
//
//  Created by Dmitriy Eliseev on 29.06.2024.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: BookOne
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                Text(book.genre.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.blue.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            Text(book.review)
                .padding()
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
                .padding()
            Text(ContentView.formatter.string(from: book.date))
                .padding()
        }//: ScrollView
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert){
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar{
            Button("Delete this book", systemImage: "trash"){
                showingDeleteAlert = true
            }
        }
    }
    func deleteBook(){
        modelContext.delete(book)
        dismiss()
    }
}

//эмитация просмотра
#Preview {
    do{
        //сохранение временно в памяти для просмотра
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: BookOne.self, configurations: config)
        let example = BookOne(title: "Test Book", author: "Test Author", genre: "Horror", review: "Best book", rating: 3, date: Date.now)
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
    
}
