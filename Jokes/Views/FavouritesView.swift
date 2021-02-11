//
//  FavouritesView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 18/07/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Ducks
import SwiftUI
import Shared

struct FavouritesView: View {
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    @EnvironmentObject var store: Store<AppState>
    @Environment(\.presentationMode) var presentation
    @State var shareSheetVisible: Bool = false
    @State var shareable: String = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(store.state.favourites, id: \.self) { value in
                    FavouritesItemView(joke: jokes[value], dispatch: store.dispatch)
                        .padding(.vertical)
                    .contextMenu(ContextMenu {
                        Button(action: {
                            store.dispatch(Actions.toggleFavourite(jokes[value]))
                        }) {
                            Image(systemName: "heart")
                                .foregroundColor(.systemRed)
                            Text("Remove as favourite")
                                .foregroundColor(Color.blue)
                        }
                        
                        Button(action: {
                            shareable = jokes[value].shareable
                            shareSheetVisible = true
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.systemRed)
                            Text("Share")
                                .foregroundColor(Color.blue)
                        }
                    })
                }
                .onDelete { set in
                    store.dispatch(Actions.removeFavourites(set))
                }
            }
            .sheet(isPresented: $shareSheetVisible) {
                ShareSheet(activityItems: [shareable])
                    .background(Color.systemGreen)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .navigationBarTitle("Favourites")
            .navigationBarItems(trailing: doneButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var doneButton: some View {
        Button(action: {
            presentation.wrappedValue.dismiss()
        }) {
            Text("Done").font(.system(size: 16, weight: .semibold))
        }
    }
}
