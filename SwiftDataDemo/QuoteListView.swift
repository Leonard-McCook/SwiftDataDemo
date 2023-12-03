//
//  QuoteListView.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 12/3/23.
//

import SwiftUI

struct QuotesListView: View {
    @Environment(\.modelContext) private var modelContext
    let game: Game
    @State private var text = ""
    @State private var page = ""
    @State private var selectedQuote: Quote?
    var isEditing: Bool {
        selectedQuote != nil
    }
    var body: some View {
        GroupBox {
            HStack {
                LabeledContent("Page") {
                    TextField("page #", text: $page)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 150)
                    Spacer()
                }
                if isEditing {
                    Button("Cancel") {
                        page = ""
                        text = ""
                        selectedQuote = nil
                    }
                    .buttonStyle(.bordered)
                }
                Button(isEditing ? "Update" : "Create") {
                    if isEditing {
                        selectedQuote?.text = text
                        selectedQuote?.page = page.isEmpty ? nil : page
                        page = ""
                        text = ""
                        selectedQuote = nil
                    } else {
                        let quote = page.isEmpty ? Quote(text: text) : Quote(text: text, page: page)
                        game.quotes?.append(quote)
                        text = ""
                        page = ""
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(text.isEmpty)
            }
            TextEditor(text: $text)
                .border(Color.secondary)
                .frame(height: 100)
        }
        .padding(.horizontal)
        List {
            let sortedQuotes = game.quotes?.sorted(using: KeyPathComparator(\Quote.creationDate)) ?? []
            ForEach(sortedQuotes) { quote in
                VStack(alignment: .leading) {
                    Text(quote.creationDate, format: .dateTime.month().day().year())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(quote.text)
                    HStack {
                        Spacer()
                        if let page = quote.page, !page.isEmpty {
                            Text("Page: \(page)")
                        }
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedQuote = quote
                    text = quote.text
                    page = quote.page ?? ""
                }
            }
            .onDelete { indexSet in
                withAnimation {
                    indexSet.forEach { index in
                        let quote = sortedQuotes[index]
                        game.quotes?.forEach{ gameQuote in
                            if quote.id == gameQuote.id {
                                modelContext.delete(quote)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Quotes")
    }
}

#Preview {
    let preview = Preview(Game.self)
    let games = Game.sampleGames
    preview.addExamples(games)
    return NavigationStack {
        QuotesListView(game: games[4])
            .navigationBarTitleDisplayMode(.inline)
            .modelContainer(preview.container)
    }
}
