//
//  ActionBarView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 08/08/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Shared
import SwiftUI
import Ducks

struct ActionBarView: View {

    var nextJoke: () -> Void

    @EnvironmentObject var store: Store<AppState>

    @State var shareSheetVisible: Bool = false
    @State var favouritesVisible: Bool = false

    var body: some View {
        HStack(alignment: .center, spacing: Measurements.medium) {
            Spacer()
            favouritesButton
            shareButton
            nextButton
        }
        .padding(Measurements.larger)
    }
    
    var nextButton: some View {
        Button(action: nextJoke) {
            Text("Next joke")
        }
        .buttonStyle(CustomButtonStyle(color: .systemBlue, square: false))
        .frame(height: 54)
    }
    
    var shareButton: some View {
        Button(action: { shareSheetVisible = true }) {
            Image(systemName: "square.and.arrow.up")
                .padding(.bottom, Measurements.small)
                .padding(.top, Measurements.smallest)
        }
        .buttonStyle(CustomButtonStyle(color: .systemGreen))
        .frame(width: 54, height: 54)
        .accessibility(label: Text("Share"))
        .sheet(isPresented: $shareSheetVisible) {
            ShareSheet(activityItems: [store.state.joke.shareable])
                .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    var favouritesButton: some View {
        Button(action: { favouritesVisible = true }) {
            Image(systemName: "heart.fill")
                .padding(.bottom, Measurements.smaller)
                .padding(.top, Measurements.smaller)
        }
        .buttonStyle(CustomButtonStyle(color: .systemPurple))
        .frame(width: 54, height: 54)
        .accessibility(label: Text("Show favourites"))
        .sheet(isPresented: $favouritesVisible) {
            FavouritesView().environmentObject(store)
        }
    }
}
