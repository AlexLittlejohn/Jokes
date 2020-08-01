//
//  SeenMiddleware.swift
//  Jokes
//
//  Created by Alex Littlejohn on 01/08/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Ducks
import Shared

let seenMiddleware: Middleware<AppState> = { store, next, action in
    
    switch action {
    case Actions.addSeen(let joke):
        
        if store.state.seen.count >= (jokes.count/2) {
            next(Actions.setSeen([]))
        } else if let index = jokes.firstIndex(of: joke) {
            next(Actions._addSeen(index))
        }
        
        return
    default:
        break
    }
    
    next(action)
}
