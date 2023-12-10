//
//  GenreSamples.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 12/9/23.
//

import Foundation

extension Genre {
    static var sampleGenres: [Genre] {
        [
            Genre(name: "Shooter", color: "00FF00"),
            Genre(name: "Role-Playing", color: "0000FF"),
            Genre(name: "Strategy", color: "FF0000"),
            Genre(name: "Racing", color: "000000"),
            Genre(name: "Action-Adventure", color: "FFA500")
        ]
    }
}
