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
    init(sortOrder: SortOrder, filterString: String) {
        let sortDescriptors: [SortDescriptor<Game>] = switch sortOrder {
        case .status:
            [SortDescriptor(\Game.status), SortDescriptor(\Game.title)]
        case .title:
            [SortDescriptor(\Game.title)]
        case .developer:
            [SortDescriptor(\Game.developer)]
        }
        let predicate = #Predicate<Game> { game in
            game.title.localizedStandardContains(filterString)
            || game.developer.localizedStandardContains(filterString)
            || filterString.isEmpty
        }
        _games = Query(filter: predicate, sort: sortDescriptors)
    }
    var body: some View {
        Group {
            if games.isEmpty {
                ContentUnavailableView("Enter your first game.", systemImage: "book.fill")
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
                                    if let genres = game.genres {
                                        ViewThatFits {
                                            GenresStackView(genres: genres)
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                GenresStackView(genres: genres)
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
