//
//  Game.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/3/23.
//


import SwiftUI
import SwiftData

@Model
class Game {
    var title: String
    var developer: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    @Attribute(originalName: "summary")
    var synopsis: String
    var rating: Int?
    var status: Status.RawValue
    var recommendedBy: String = ""
    var quotes: [Quote]?
    
    init(
        title: String,
        developer: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        synopsis: String = "",
        rating: Int? = nil,
        status: Status = .inBacklog,
        recommendedBy: String = ""
    ) {
        self.title = title
        self.developer = developer
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.synopsis = synopsis
        self.rating = rating
        self.status = status.rawValue
        self.recommendedBy = recommendedBy
    }
    
    var icon: Image {
        switch Status(rawValue: status)! {
        case .inBacklog:
            Image(systemName: "gamecontroller")
        case .inProgress:
            Image(systemName: "hourglass.circle")
        case .completed:
            Image(systemName: "checkmark.diamond.fill")
        }
    }
}


enum Status: Int, Codable, Identifiable, CaseIterable {
    case inBacklog, inProgress, completed
    var id: Self {
        self
    }
    var descr: String {
        switch self {
        case .inBacklog:
            "In Backlog"
        case .inProgress:
            "In Progress"
        case .completed:
            "Completed"
        }
    }
}
