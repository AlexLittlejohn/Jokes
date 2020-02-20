//
//  State.swift
//  Jokes
//
//  Created by Alex Littlejohn on 14/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Foundation
import Ducks

struct Joke: Codable {
    let id, joke: String
    let status: Int
}

struct AppState: StateType {
    let viewState: ViewState
    let imageNumber: Int
    static let empty = AppState(viewState: .empty, imageNumber: 0)
}

enum ViewState: StateType {
    case populated(Joke)
    case loading
    case error
    case empty
}

extension AppState {
    var isLoading: Bool {
        switch viewState {
        case .loading:
            return true
        default:
            return false
        }
    }
}
