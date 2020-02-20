//
//  ContentView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 14/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Ducks
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var store: Store<AppState>
    
    @State var aboutVisible = false
    
    var body: some View {
        VStack(alignment: .center) {
            BackgroundView().environmentObject(store)
            
            VStack(spacing: 16) {
                Text("Alex's lame jokes").modifier(HeadingLabel())
                
                ScrollView {
                    ViewStateView(viewState: store.state.viewState) { item in
                        Text(item.joke).modifier(PrimaryLabel())
                    }
                }
                Spacer()
                
                FancyButtonView(title: "Tell me another joke!", action: {
                    self.store.dispatch(Actions.fetch)
                })
                    .disabled(store.state.isLoading)
                    .frame(alignment: .bottomLeading)
            }
            .padding()
            .frame(minWidth: 1, maxWidth: .infinity)
            
        }
        .multilineTextAlignment(.center)
        .overlay(InfoButtonView(title: "About", action: {
            self.aboutVisible = true
        }), alignment: .topTrailing)
        .frame(minWidth: 1, maxWidth: .infinity, minHeight: 1, maxHeight: .infinity, alignment: .topLeading)
        .sheet(isPresented: $aboutVisible) {
            AboutView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store(reducer: reducer, state: AppState.empty, middleware: [networkingMiddleware]))
    }
}
