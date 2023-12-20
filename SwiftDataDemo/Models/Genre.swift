//
//  Genre.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 12/6/23.
//

import SwiftUI
import SwiftData

@Model
class Genre {
    var name: String = ""
    var color: String = "FF0000"
    var games: [Game]?
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}
