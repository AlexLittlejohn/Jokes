//
//  ContentView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 14/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Ducks
import SwiftUI

extension State {
    var isLoading: Bool {
        switch viewState {
        case .loading:
            return true
        default:
            return false
        }
    }
}

struct ContentView: View {
    
    @EnvironmentObject var store: Store<State>
    
    fileprivate func extractedFunc() -> some View {
        return Button(action: {
            self.store.dispatch(Actions.fetch)
        }) {
            Text("Another joke!")
                .font(Font.headline)
                .foregroundColor(Color("the_color"))
                .padding()
                .background(Color.white)
                .clipShape(Capsule())
            
        }
    }
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(Color("the_color"))
                .frame(minWidth: 1, maxWidth: CGFloat.greatestFiniteMagnitude, minHeight: 1, maxHeight: CGFloat.greatestFiniteMagnitude, alignment: .topLeading)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                Image("flame-\(self.store.state.imageNumber)")
                    .resizable()
                    .frame(width: geometry.size.width * 2, height: geometry.size.width * 2, alignment: .top)
                    .aspectRatio(contentMode: .fit)
                .padding(.top, geometry.size.width)
            }.frame(alignment: .bottom)
            
            
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Jokes").modifier(HeadingLabel())
                
                ViewStateView(viewState: store.state.viewState) { item in
                    ScrollView {
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
            .frame(minWidth: 1, maxWidth: CGFloat.greatestFiniteMagnitude, minHeight: 1, maxHeight: CGFloat.greatestFiniteMagnitude, alignment: .topLeading)
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store(reducer: reducer, state: State.empty, middleware: [networkingMiddleware]))
    }
}
