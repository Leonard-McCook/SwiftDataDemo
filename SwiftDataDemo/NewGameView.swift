//
//  NewGameView.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/7/23.
//

import SwiftUI

struct NewGameView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var developer = ""
    var body: some View {
        NavigationStack {
            Form {
                TextField("Game Title", text: $title)
                TextField("Developer", text: $developer)
                Button("Add Game") {
                    let newGame = Game(title: title, developer: developer)
                    context.insert(newGame)
                    dismiss()
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(title.isEmpty || developer.isEmpty)
                .navigationTitle("New Game")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewGameView()
}
