//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/3/23.
//

import SwiftUI
import SwiftData

enum SortOrder: LocalizedStringResource, Identifiable, CaseIterable {
    case status, title, developer
    
    var id: Self {
        self
    }
}

struct GameListView: View {
    @State private var createNewGame = false
    @State private var sortOrder = SortOrder.status
    @State private var filter = ""
    var body: some View {
        NavigationStack {
            Picker("", selection: $sortOrder) {
                ForEach(SortOrder.allCases) { sortOrder in
                    Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            .buttonStyle(.bordered)
            GameList(sortOrder: sortOrder, filterString: filter)
                .searchable(text: $filter, prompt: Text("Filter on title or developer"))
                .navigationTitle("My Games")
                .toolbar {
                    Button {
                        createNewGame = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
                .sheet(isPresented: $createNewGame) {
                    NewGameView()
                        .presentationDetents([.medium])
                }
        }
    }
}

#Preview ("English") {
    let preview = Preview(Game.self)
    let games = Game.sampleGames
    let genres = Genre.sampleGenres
    preview.addExamples(games)
    preview.addExamples(genres)
    return GameListView()
        .modelContainer(preview.container)
}

#Preview ("Spanish") {
    let preview = Preview(Game.self)
    let games = Game.sampleGames
    let genres = Genre.sampleGenres
    preview.addExamples(games)
    preview.addExamples(genres)
    return GameListView()
        .modelContainer(preview.container)
        .environment(\.locale, Locale(identifier: "es"))
}
