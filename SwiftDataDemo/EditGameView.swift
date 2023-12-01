//
//  EditGameView.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/13/23.
//

import SwiftUI

struct EditGameView: View {
    @Environment(\.dismiss) private var dismiss
    let game: Game
    @State private var status = Status.inBacklog
    @State private var rating: Int?
    @State private var title = ""
    @State private var developer = ""
    @State private var synopsis = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var firstView = true
    
    var body: some View {
        HStack {
            Text("Status")
            Picker("Status", selection: $status) {
                ForEach(Status.allCases) { status in
                    Text(status.descr).tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
        VStack(alignment: .leading) {
            GroupBox {
                LabeledContent {
                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                } label: {
                    Text("Date Added")
                }
                if status == .inProgress || status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }
                }
                if status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateCompleted, in: dateStarted..., displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }
                }
            }
            .foregroundStyle(.secondary)
            .onChange(of: status) { oldValue, newValue in
                if !firstView {
                    if newValue == .inBacklog {
                        dateStarted = Date.distantPast
                        dateCompleted = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .completed {
                        // from completed to inProgress
                        dateCompleted = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .inBacklog {
                        // Game has been started
                        dateStarted = Date.now
                    } else if newValue == .completed && oldValue == .inBacklog {
                        // Forgot to start game
                        dateCompleted = Date.now
                        dateStarted = dateAdded
                    } else {
                        // completed
                        dateCompleted = Date.now
                    }
                    firstView = false
                }
            }
            Divider()
            LabeledContent {
                RatingsView(maxRating: 5, currentRating: $rating, width: 30)
            } label: {
                Text("Rating")
            }
            LabeledContent {
                TextField("", text: $title)
            } label: {
                Text("Title").foregroundStyle(.secondary)
            }
            LabeledContent {
                TextField("", text: $developer)
            } label: {
                Text("Developer").foregroundStyle(.secondary)
            }
            Divider()
            Text("Synopsis").foregroundStyle(.secondary)
            TextEditor(text: $synopsis)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if changed {
                Button("Update") {
                    game.status = status.rawValue
                    game.rating = rating
                    game.title = title
                    game.developer = developer
                    game.synopsis = synopsis
                    game.dateAdded = dateAdded
                    game.dateStarted = dateStarted
                    game.dateCompleted = dateCompleted
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            status = Status(rawValue: game.status)!
            rating = game.rating
            title = game.title
            developer = game.developer
            synopsis = game.synopsis
            dateAdded = game.dateAdded
            dateStarted = game.dateStarted
            dateCompleted = game.dateCompleted
        }
    }
    
    var changed: Bool {
        status != Status(rawValue: game.status)!
        || rating != game.rating
        || title != game.title
        || developer != game.developer
        || synopsis != game.synopsis
        || dateAdded != game.dateAdded
        || dateStarted != game.dateStarted
        || dateCompleted != game.dateCompleted
    }
}

#Preview {
    let preview = Preview(Game.self)
    return NavigationStack {
        EditGameView(game: Game.sampleGames[2])
            .modelContainer(preview.container)
    }
}
