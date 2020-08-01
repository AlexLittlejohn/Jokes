//
//  Actions.swift
//  Jokes
//
//  Created by Alex Littlejohn on 14/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Ducks
import Shared

enum Actions: Action {
    case randomJoke
    case setJoke(Joke)
    case toggleFavourite(Joke)
    case _toggleFavourite(Int)
    case setFavourites([Int])
    case addSeen(Joke)
    case _addSeen(Int)
    case setSeen([Int])
    case removeFavourites(IndexSet)
}
