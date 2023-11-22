//
//  GameSamples.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/22/23.
//

import Foundation

extension Game {
    static let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!
    static let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date.now)!
    static var sampleGames: [Game] { 
        [
            Game(title: "Gears 5",
                 developer: "The Coalition"),
            Game(title: "Halo Infinite",
                 developer: "347 Industries",
                 dateAdded: lastWeek,
                 dateStarted: Date.now,
                 status: Status.inProgress),
            Game(title: "Armored Core",
                 developer: "FromSoftware",
                 dateAdded: lastMonth,
                 dateStarted: lastWeek,
                 dateCompleted: Date.now,
                 summary: "Armored Core is a third-person shooter mecha video game series developed by FromSoftware. The series centers on a silent protagonist who takes on work as a mercenary pilot in the far future, operating large robot combat units known as Armored Cores at the behest of corporate and private clients.",
                 rating: 4,
                 status: Status.completed),
            Game(title: "Diablo IV",
                 developer: "Blizzard Entertaiment"),
            Game(title: "Dead Island 2",
                 developer: "Dambuster Studios",
                 dateAdded: lastMonth,
                 dateStarted: lastWeek,
                 dateCompleted: Date.now,
                 summary: "Dead Island 2 takes place in Los Angeles, in the middle of a zombie plague that has turned most of the city into gibbering undead. One of the last evacuation planes crashes with six people — the player characters, or Slayers — aboard.",
                 rating: 3,
                 status: Status.completed),
            Game(title: "Forza Horizon 5",
                 developer: "Playground Games"),
            Game(title: "Red Dead Redemption 2",
                 developer: "Rockstar Studios",
                 dateAdded: lastWeek,
                 dateStarted: Date.now,
                 status: Status.inProgress),
            Game(title: "Cyberpunk 2077",
                 developer: "CD Projekt Red",
                 dateAdded: lastMonth,
                 dateStarted: lastWeek,
                 summary: "Set in a dystopian cyberpunk universe, the player assumes the role of 'V' (played by Gavin Drea/Cherami Leigh), a mercenary in the fictional Californian city known as 'Night City', where they deal with the fallout from a heist gone wrong that results in an experimental cybernetic 'bio-chip' containing an engram of the legendary rock star and terrorist Johnny Silverhand (played by Keanu Reeves) threatening to slowly overwrite V's mind; as the story progresses V and Johnny must work together to find a way to be separated and save V's life.",
                 rating: 5,
                 status: Status.completed)
        ]
    }
}
