//
//  BookView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 08/08/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import SwiftUI

struct BookView: View {
    @State var rotation: Angle = .zero
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        Image("icon")
            .resizable().antialiased(true)
            .aspectRatio(contentMode: .fit)
            .accessibility(label: Text("The Joke Book"))
            .frame(width: horizontalSizeClass == .regular ? 34 : 22)
            .rotationEffect(rotation)
            .animation(.spring())
            .onTapGesture {
                if rotation == Rotation.zero.value {
                    rotation = Rotation.random.value
                } else {
                    rotation = Rotation.zero.value
                }
        }
    }
}
