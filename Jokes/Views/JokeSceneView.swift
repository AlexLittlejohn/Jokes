//
//  JokeSceneView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 10/07/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Ducks
import PopupView
import SwiftUI
import Shared

struct JokeSceneView: View {
    
    @EnvironmentObject var store: Store<AppState>
    @State var sheetVisible: Bool = false
    @State var shareSheetVisible: Bool = false
    @State var favouritesVisible: Bool = false
    @State var showingPopup: Bool = false
    @State var popupContent: PopupContent = PopupContent()
        
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: Measurements.medium) {
                    
                    favouriteButton
                    
                    JokeView(joke: store.state.joke)
                        .contextMenu(ContextMenu {
                            contextCopyButton
                        })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .transition(.moveAndFade)
                .id("JokeScene" + store.state.joke.setup + store.state.joke.punchline)
                .overlay(BookView(), alignment: .topTrailing)
            }
            .padding(Measurements.larger)
            .padding(.bottom, Measurements.largest + Measurements.large)
        }
        .sheet(isPresented: $sheetVisible) {
            if self.shareSheetVisible {
                ShareSheet(activityItems: [self.store.state.joke.shareable])
                    .background(Color.systemGreen)
                    .edgesIgnoringSafeArea(.bottom)
            } else {
                FavouritesView().environmentObject(self.store)
            }
        }
        .popup(isPresented: $showingPopup, type: .floater(), position: .top, animation: Animation.spring(), autohideIn: 2) {
                PopupContentView(content: self.popupContent)
        }
        .overlay(actionBar, alignment: .bottomLeading)
    }
    
    var actionBar: some View {
        ActionBarView(
            nextJoke: nextJoke,
            showShareSheet: showShareSheet,
            showFavourites: showFavourites
        )
    }
    
    var favouriteButton: some View {
        Button(action: toggleFavourite) {
            Image(systemName: store.state.isFavourite() ? "heart.fill" : "heart")
                .padding(.vertical, Measurements.smaller)
                .padding(.trailing, Measurements.smaller)
                .foregroundColor(.systemRed)
                .font(Font.system(size: 18, weight: .semibold))
        }
        .accessibility(label: Text(store.state.isFavourite() ? "Remove as favourite" : "Mark as favourite"))
    }
    
    var contextCopyButton: some View {
        Button(action: {
            UIPasteboard.general.string = self.store.state.joke.shareable
            self.popupContent = copyPopupContent
            self.showingPopup = true
        }) {
            Image(systemName: "doc.on.doc")
                .foregroundColor(.systemRed)
            Text("Copy")
                .foregroundColor(Color.blue)
        }
    }
    
    func nextJoke() {
        withAnimation(.spring()) {
            self.store.dispatch(Actions.randomJoke)
        }
    }
    
    func showShareSheet() {
        shareSheetVisible = true
        favouritesVisible = false
        sheetVisible = true
    }
    
    func showFavourites() {
        shareSheetVisible = false
        favouritesVisible = true
        sheetVisible = true
    }
    
    func toggleFavourite() {
        popupContent = store.state.isFavourite() ? removeFavouritePopupContent : addFavouritePopupContent
        showingPopup = true
        store.dispatch(Actions.toggleFavourite(store.state.joke))
    }
}

struct JokeSceneView_Previews: PreviewProvider {
    
    static let store = Store(reducer: reducer, state: AppState.empty, middleware: [favouritesMiddleware])
    
    static var previews: some View {
        Group {
            JokeSceneView()
                .environmentObject(store)
            
            JokeSceneView()
                .environmentObject(store)
                .environment(\.colorScheme, .dark)
        }
    }
}
