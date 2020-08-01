//
//  SceneDelegate.swift
//  Jokes
//
//  Created by Alex Littlejohn on 14/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import UIKit
import SwiftUI
import Ducks
import Combine
import Shared

let seenKey = "seen"
let favouritesKey = "favourites"

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var cancellables: [AnyCancellable] = []

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let store = Store(reducer: reducer, state: AppState.empty, middleware: [favouritesMiddleware, seenMiddleware])
        let previouslySeen = UserDefaults.standard.array(forKey: seenKey) as? [Int] ?? []
        let savedFavourites = UserDefaults.standard.array(forKey: favouritesKey) as? [Int] ?? []
        
        let unseen = Set(0..<jokes.count).subtracting(previouslySeen)
        
        if let r = unseen.randomElement(), 0..<jokes.count ~= r {
            store.dispatch(Actions.setJoke(jokes[r]))
        }
        
        store.dispatch(Actions.setSeen(previouslySeen))
        store.dispatch(Actions.setFavourites(savedFavourites))

        store.$state.map(\.favourites).removeDuplicates().sink {
            UserDefaults.standard.set($0, forKey: favouritesKey)
        }.store(in: &cancellables)

        store.$state.map(\.seen).removeDuplicates().sink {
            UserDefaults.standard.set($0, forKey: seenKey)
        }.store(in: &cancellables)

        let view = JokeSceneView().environmentObject(store)

        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = UIHostingController(rootView: view)
            window?.makeKeyAndVisible()
        }
    }
}
