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
    @State var shareSheetVisible: Bool = false
    @State var shareable: String = ""

    var body: some View {
        List {
            ForEach(store.state.favourites, id: \.self) { value in
                HStack {
                    VStack(alignment: .leading, spacing: Measurements.smallest) {
                        Text("\(jokes[value].setup)")
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(Color.secondaryLabel)
                        Text("\(jokes[value].punchline)")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color.label)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                        print("hello")
                        self.store.dispatch(Actions.toggleFavourite(jokes[value]))
                    }, label: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.systemRed)
                    }).buttonStyle(BorderlessButtonStyle())
                }
                .padding(Measurements.medium)
                .contextMenu(ContextMenu {
                    Button(action: {
                        self.store.dispatch(Actions.toggleFavourite(jokes[value]))
                    }, label: {
                        Image(systemName: "heart")
                            .foregroundColor(.systemRed)
                        Text("Remove as favourite")
                            .foregroundColor(Color.blue)
                    })
                    Button(action: {
                        self.shareable = jokes[value].shareable
                        self.shareSheetVisible = true
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.systemRed)
                        Text("Share")
                            .foregroundColor(Color.blue)
                    })
                })
            }.onDelete(perform: { set in
                self.store.dispatch(Actions.removeFavourites(set))
            })
        }.sheet(isPresented: self.$shareSheetVisible, content: {
            ShareSheet(activityItems: [self.shareable])
                .background(Color.systemGreen)
                .edgesIgnoringSafeArea(.bottom)
        })
    }
}
