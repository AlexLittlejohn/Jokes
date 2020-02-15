//
//  Reducer.swift
//  Jokes
//
//  Created by Alex Littlejohn on 14/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Foundation
import Ducks

let reducer: Reducer<State> = { action, state in
    State(
        viewState: viewStateReducer(action, state.viewState),
        imageNumber: imageNumberReducer(action, state.imageNumber)
    )
}

let viewStateReducer: Reducer<ViewState> = { action, state in
    
    switch action {
    case Actions.setJoke(let joke):
        return .populated(joke)
    case Actions.setLoading:
        return .loading
    case Actions.setError:
        return .error
    case Actions.setEmpty:
        return .empty
    case Actions.setViewState(let newState):
        return newState
    default:
        return state
    }
}

let imageNumberReducer: Reducer<Int> = { action, state in
    switch action {
    case Actions.randomize:
        return Int.random(in: 1...39)
    default:
        return state
    }
}
