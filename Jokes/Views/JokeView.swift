//
//  JokeView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 08/08/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Shared
import SwiftUI

struct JokeView: View {
    @State var punchlineVisible: Bool = false
    
    var joke: Joke

    var body: some View {
        VStack(spacing: Measurements.medium) {
            setup
            
            if !punchlineVisible {
                revealButton
            } else {
                punchline
            }
        }
    }
    
    var setup: some View {
        Text(joke.setup)
            .foregroundColor(.label)
            .lineLimit(nil)
            .minimumScaleFactor(0.5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .font(Font.system(size: 44, weight: .heavy))
            .animation(nil)
            .opacity(punchlineVisible ? 0.4 : 1)
            .animation(.spring())
    }
    
    var punchline: some View {
        Text(joke.punchline)
            .lineLimit(nil)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.label)
            .font(Font.system(size: 32, weight: .heavy))
            .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
            .animation(.spring())
    }
    
    
    var revealButton: some View {
        Button(action: showPunchline, label: {
            Text("Reveal punchline")
                .font(Font.system(size: 32, weight: .heavy))
                .frame(maxWidth: .infinity, alignment: .leading)
        })
            .transition(.opacity)
            .frame(maxWidth: .infinity, alignment: .leading)
            .animation(.spring())
    }

    func showPunchline() {
        withAnimation(.spring()) {
            self.punchlineVisible = true
        }
    }
}
