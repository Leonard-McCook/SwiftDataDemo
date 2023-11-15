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
            
        }
    }
}

#Preview {
    EditGameView()
}
