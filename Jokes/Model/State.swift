//
//  State.swift
//  Jokes
//
//  Created by Alex Littlejohn on 14/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Foundation
import Ducks
import Shared

struct AppState: StateType {
    let joke: Joke
    let favourites: [Int]
    let seen: [Int]
    
    static let empty = AppState(joke: jokes[Int.random(in: 0..<jokes.count)], favourites: [], seen: [])
}

extension AppState {
    func isFavourite() -> Bool {
        guard let index = jokes.firstIndex(of: joke) else { return false }
        return favourites.contains(index)
    }
}

