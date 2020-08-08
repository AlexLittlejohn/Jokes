//
//  Joke.swift
//  Shared
//
//  Created by Alex Littlejohn on 20/03/2020.
//  Copyright © 2020 zero. All rights reserved.
//

public struct Joke: Hashable {
    public let setup, punchline: String
    
    public var shareable: String {
        return setup + "\n\n\n" + punchline
    }
}
