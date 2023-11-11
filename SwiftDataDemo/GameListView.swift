//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/3/23.
//

import SwiftUI
import SwiftData

struct GameListView: View {
    @Query(sort: \Game.title) private var games: [Game]
    @State private var createNewGame = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(games) { game in
                    NavigationLink {
                        Text(game.title)
                    } label: {
                        HStack(spacing: 10) {
                            game.icon
                            VStack(alignment: .leading) {
                                Text(game.title).font(.title2)
                                Text(game.developer).foregroundStyle(.secondary)
                                
                                if let rating = game.rating {
                                    HStack {
                                        ForEach(0..<rating, id: \.self) { _ in
                                        
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
            }
            .listStyle(.plain)
            .navigationTitle("My Games")
            .toolbar {
                Button {
                    createNewGame = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
            .sheet(isPresented: $createNewGame, content: {
                NewGameView()
                    .presentationDetents([.medium])
            })
        }
    }
}

#Preview {
    GameListView()
        .modelContainer(for: Game.self, inMemory: true)
}
