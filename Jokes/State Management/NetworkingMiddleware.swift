//
//  NetworkingMiddleware.swift
//  Jokes
//
//  Created by Alex Littlejohn on 14/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Foundation
import Ducks

let networkingMiddleware: Middleware<State> = { store, next, action in
    switch action {
    case Actions.fetch:
        let url = URL(string: "https://icanhazdadjoke.com/")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Jokes iOS app (https://github.com/alittlejohn/jokes)", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            guard let data = data, let joke = try? JSONDecoder().decode(Joke.self, from: data) else {
                DispatchQueue.main.async {
                    store.dispatch(Actions.setError)
                }
                return
            }
            
            DispatchQueue.main.async {
                store.dispatch(Actions.randomize)
                store.dispatch(Actions.setJoke(joke))
            }
        }.resume()
        
        next(Actions.setLoading)
        
    default:
        next(action)
    }
}
