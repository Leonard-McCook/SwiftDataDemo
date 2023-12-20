//
//  Quote.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 12/2/23.
//

import Foundation
import SwiftData

@Model
class Quote {
    var creationDate: Date = Date.now
    var text: String = ""
    var page: String?
    
    init(text: String, page: String? = nil) {
        self.text = text
        self.page = page
    }
    
    var game: Game?
}
