//
//  TextStyleModifiers.swift
//  Jokes
//
//  Created by Alex Littlejohn on 15/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import SwiftUI

struct PrimaryLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .font(Font.system(size: 38, weight: .thin, design: .rounded))
            .shadow(radius: 6)
    }
}

struct HeadingLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .font(Font.system(size: 38, weight: .heavy, design: .rounded))
            .shadow(radius: 3)
    }
}
