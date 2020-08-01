//
//  Reducer.swift
//  Jokes
//
//  Created by Alex Littlejohn on 14/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Foundation
import Ducks
import Shared

let reducer: Reducer<AppState> = { action, state in
    AppState(
        joke: jokeReducer(action, state.joke),
        favourites: favouritesReducer(action, state.favourites),
        seen: seenReducer(action, state.seen)
    )
}

let jokeReducer: Reducer<Joke> = { action, state in
    switch action {
    case Actions.randomJoke:
        return jokes[Int.random(in: 0..<jokes.count)]
    default:
        return state
    }
}

let favouritesReducer: Reducer<[Int]> = { action, state in
    switch action {
    case Actions._toggleFavourite(let favourite):
        var favourites = state

        if let index = state.firstIndex(of: favourite) {
            favourites.remove(at: index)
        } else {
            favourites.append(favourite)
        }

        return favourites
    case Actions.setFavourites(let favourites):
        return favourites
    case Actions.removeFavourites(let set):
        return state.then { $0.remove(atOffsets: set) }
    default:
        return state
    }
}

let seenReducer: Reducer<[Int]> = { action, state in
    switch action {
    case Actions._addSeen(let joke):
        return state.then { $0.append(joke) }
    default:
        return state
    }
}
