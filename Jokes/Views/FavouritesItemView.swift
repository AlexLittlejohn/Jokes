//
//  FavouritesItemView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 08/08/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Ducks
import Shared
import SwiftUI

struct FavouritesItemView: View {
    var joke: Joke
    var dispatch: (Action) -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Measurements.smallest) {
                Text("\(joke.setup)")
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(Color.secondaryLabel)
                Text("\(joke.punchline)")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color.label)
            }
            
            Spacer()
            
            Button(action: {
                dispatch(Actions.toggleFavourite(self.joke))
            }) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.systemRed)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}
