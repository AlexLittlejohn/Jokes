//
//  ViewStateView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 14/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import SwiftUI

struct ViewStateView<Content: View>: View {
    
    let content: (Joke) -> Content
    let viewState: ViewState
    
    public init(viewState: ViewState, @ViewBuilder content: @escaping (Joke) -> Content) {
        self.content = content
        self.viewState = viewState
    }
    
    var body: some View {
        switch viewState {
        case .populated(let value):
            return AnyView(content(value))
        case .loading:
            return AnyView(LoadingView(style: .large))
        case .error:
            return AnyView(Text("sad panda").modifier(PrimaryLabel()))
        case .empty:
            return AnyView(Text("bored panda").modifier(PrimaryLabel()))
        }
    }
}
