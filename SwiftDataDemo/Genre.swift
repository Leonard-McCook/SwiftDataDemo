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
    var name: String
    var color: String
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
}
