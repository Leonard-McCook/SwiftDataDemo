//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/3/23.
//

import SwiftUI
import SwiftData

enum SortOrder: String, Identifiable, CaseIterable {
    case status, title, developer
    
    var id: Self {
        self
    }
}

struct GameListView: View {
    @State private var createNewGame = false
    @State private var sortOrder = SortOrder.status
    var body: some View {
        NavigationStack {
            Picker("", selection: $sortOrder) {
                ForEach(SortOrder.allCases) { sortOrder in
                    Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            .buttonStyle(.bordered)
            GameList()
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
