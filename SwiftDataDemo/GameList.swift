//
//  GameList.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/27/23.
//

import SwiftUI
import SwiftData

struct GameList: View {
    @Environment(\.modelContext) private var context
    @Query private var games: [Game]
    
    var body: some View {
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
    }
}

#Preview {
    let preview = Preview(Game.self)
    preview.addExamples(Game.sampleGames)
    return NavigationStack {
        GameList(sortOrder: .status, filterString: "")
    }
    .modelContainer(preview.container)
}
