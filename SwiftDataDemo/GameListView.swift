//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/3/23.
//

import SwiftUI

struct GameListView: View {
    @State private var createNewGame = false
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
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
}
