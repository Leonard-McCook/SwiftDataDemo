//
//  Book.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/3/23.
//

import Foundation

class Game {
    var title: String
    var developer: String
    var dateAdded: Date
    var dateCompleted: Date
    var sumamry: String
    var rating: Int?
    var status: Status
    
    init(
        title: String,
        developer: String,
        dateAdded: Date,
        dateCompleted: Date,
        sumamry: String,
        rating: Int? = nil,
        status: Status
    ) {
        self.title = title
        self.developer = developer
        self.dateAdded = dateAdded
        self.dateCompleted = dateCompleted
        self.sumamry = sumamry
        self.rating = rating
        self.status = status
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
