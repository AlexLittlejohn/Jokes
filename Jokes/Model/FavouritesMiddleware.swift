//
//  FavouritesMiddleware.swift
//  Jokes
//
//  Created by Alex Littlejohn on 13/07/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Ducks
import Shared

let favouritesMiddleware: Middleware<AppState> = { store, next, action in
    
    switch action {
    case Actions.toggleFavourite(let joke):
        guard let index = jokes.firstIndex(of: joke) else { return }
        next(Actions._toggleFavourite(index))
    default:
        break
    }
    
    next(action)
}
