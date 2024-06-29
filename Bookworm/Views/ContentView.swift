//
//  ContentView.swift
//  Bookworm
//
//  Created by Dmitriy Eliseev on 28.06.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    //@Query var books: [Book]
    
    //сортировка по одному полю
    //@Query(sort: \Book.title) var books: [Book]
    
    //сортировка по рейтингу от самого высокого к самому низкому
    //@Query(sort: \Book.rating, order: .reverse) var books: [Book]
    
    //сортировка по нескольким полям с использованием SortDescriptor type
    @Query(sort: [
        SortDescriptor(\BookOne.title),
        SortDescriptor(\BookOne.author)
    ]) var books: [BookOne]
    @State private var showingAddScreen = false
    
    static var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        return formatter
    }
    
    var body: some View {
        NavigationStack{
            // Text("Count: \(books.count)")
            List{
                ForEach(books){book in
                    NavigationLink(value: book){
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading){
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating < 2 ? .red : .black)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                                
                            }
                        }
                    }
                    
                }
                .onDelete(perform: deliteBooks)
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: BookOne.self){book in
                DetailView(book: book)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add Book", systemImage: "plus"){
                        showingAddScreen.toggle()
                    }
                }
                
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deliteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
