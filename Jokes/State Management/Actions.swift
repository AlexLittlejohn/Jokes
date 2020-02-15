//
//  Actions.swift
//  Jokes
//
//  Created by Alex Littlejohn on 14/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Foundation
import Ducks

enum Actions: Action {
    case fetch
    case setJoke(Joke)
    case setLoading
    case setError
    case setEmpty
    case setViewState(ViewState)
    case randomize
}
