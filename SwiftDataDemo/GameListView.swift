//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/3/23.
//

import SwiftUI
import SwiftData

struct GameListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Game.title) private var games: [Game]
    @State private var createNewGame = false
    var body: some View {
        NavigationStack {
            Group {
                if games.isEmpty {
                    ContentUnavailableView("Add game to your list", systemImage: "xbox.logo")
                } else {
                    List {
                        ForEach(games) { game in
                            NavigationLink {
                                EditGameView(game: game)
                            } label: {
                                HStack(spacing: 10) {
                                    game.icon
                                    VStack(alignment: .leading) {
                                        Text(game.title).font(.title2)
                                        Text(game.developer).foregroundStyle(.secondary)
                                        
                                        if let rating = game.rating {
                                            HStack {
                                                ForEach(1..<rating, id: \.self) { _ in
                                                    
                                                    Image(systemName: "star.fill")
                                                        .imageScale(.small)
                                                        .foregroundStyle(.yellow)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let game = games[index]
                                context.delete(game)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
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

#Preview {
    let preview = Preview(Game.self)
    preview.addExamples(Game.sampleGames)
    return GameListView()
        .modelContainer(preview.container)
}
