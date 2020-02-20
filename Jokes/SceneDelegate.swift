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

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let store = Store(reducer: reducer, state: AppState.empty, middleware: [networkingMiddleware])
        
        store.dispatch(Actions.fetch)
        
        let contentView = ContentView()
            .environmentObject(store)
            

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.backgroundColor = UIColor(red: 0, green: 255/145, blue: 1, alpha: 1)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

