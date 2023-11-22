//
//  SwiftDataDemoApp.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/3/23.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataDemoApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            GameListView()
        }
//        .modelContainer(for: Game.self)
        .modelContainer(container)
    }
    
    init() {
        let schema = Schema([Game.self])
        let config = ModelConfiguration("MyGames", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
//        let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBooks.store"))
//        do {
//            container = try ModelContainer(for: Book.self, configurations: config)
//        } catch {
//            fatalError("Could not configure the container")
//        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
//        print(URL.documentsDirectory.path())
    }
}
