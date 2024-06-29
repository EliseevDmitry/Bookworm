//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Dmitriy Eliseev on 28.06.2024.
//
import SwiftData
import SwiftUI

@main
//Объекты модели SwiftData должны создаваться внутри контекста модели.
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: BookOne.self)
    }
}
