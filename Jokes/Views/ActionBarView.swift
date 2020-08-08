//
//  ActionBarView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 08/08/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Shared
import SwiftUI

struct ActionBarView: View {

    var nextJoke: () -> Void
    var showShareSheet: () -> Void
    var showFavourites: () -> Void

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
    }
    
    var shareButton: some View {
        Button(action: showShareSheet) {
            Image(systemName: "square.and.arrow.up")
                .padding(.bottom, Measurements.small)
                .padding(.top, Measurements.smallest)
        }
        .buttonStyle(CustomButtonStyle(color: .systemGreen))
        .accessibility(label: Text("Share"))
    }
    
    var favouritesButton: some View {
        Button(action: showFavourites) {
            Image(systemName: "heart.fill")
                .padding(.bottom, Measurements.smaller)
                .padding(.top, Measurements.smaller)
        }
        .buttonStyle(CustomButtonStyle(color: .systemPurple))
        .accessibility(label: Text("Show favourites"))
    }
}
