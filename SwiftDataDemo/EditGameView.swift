//
//  EditGameView.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/13/23.
//

import SwiftUI

struct EditGameView: View {
//    let game: Game
    @State private var status = Status.inBacklog
    @State private var rating: Int?
    @State private var title = ""
    @State private var developer = ""
    @State private var summary = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    EditGameView()
}
