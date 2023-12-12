//
//  GenresView.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 12/11/23.
//

import SwiftData
import SwiftUI

struct GenresView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Bindable var game: Game
    @Query(sort: \Genre.name) var genres: [Genre]
    @State private var newGenre = false
    var body: some View {
        NavigationStack {
            Group {
                if genres.isEmpty {
                    ContentUnavailableView {
                        Image(systemName: "bookmark.fill")
                            .font(.largeTitle)
                    } description: {
                        Text("You need to create some genres first.")
                    } actions: {
                        Button("Create Genre") {
                            newGenre.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List {
                        ForEach(genres) { genre in
                            HStack {
                                if let gameGenres = game.genres {
                                    if gameGenres.isEmpty {
                                        Button {
                                            addRemove(genre)
                                        } label: {
                                            Image(systemName: "circle")
                                        }
                                        .foregroundStyle(genre.hexColor)
                                    } else {
                                        Button {
                                            addRemove(genre)
                                        } label: {
                                            Image(systemName: gameGenres.contains(genre) ? "circle.fill" : "circle")
                                        }
                                        .foregroundStyle(genre.hexColor)
                                    }
                                }
                                Text(genre.name)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                if let gameGenres = game.genres,
                                   gameGenres.contains(genres[index]),
                                   let gameGenreIndex = gameGenres.firstIndex(where: {$0.id == genres[index].id}) {
                                    game.genres?.remove(at: gameGenreIndex)
                                }
                                context.delete(genres[index])
                            }
                        })
                        LabeledContent {
                            Button {
                                newGenre.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                            }
                            .buttonStyle(.borderedProminent)
                        } label: {
                            Text("Create new Genre")
                                .font(.caption).foregroundStyle(.secondary)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(game.title)
            .sheet(isPresented: $newGenre) {
                NewGenreView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func addRemove(_ genre: Genre) {
        if let gameGenres = game.genres {
            if gameGenres.isEmpty {
                game.genres?.append(genre)
            } else {
                if gameGenres.contains(genre),
                   let index = gameGenres.firstIndex(where: {$0.id == genre.id}) {
                    game.genres?.remove(at: index)
                } else {
                    game.genres?.append(genre)
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(Game.self)
    let games = Game.sampleGames
    let genres = Genre.sampleGenres
    preview.addExamples(genres)
    preview.addExamples(games)
    games[1].genres?.append(genres[0])
    return GenresView(game: games[1])
        .modelContainer(preview.container)
}
