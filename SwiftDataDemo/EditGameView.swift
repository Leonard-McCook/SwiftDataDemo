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
                        DatePicker("", selection: $dateStarted, displayedComponents: .date)
                    } label: {
                         Text("Date Started")
                    }
                }
                if status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateCompleted, displayedComponents: .date)
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
        }
    }
}

#Preview {
    EditGameView()
}
