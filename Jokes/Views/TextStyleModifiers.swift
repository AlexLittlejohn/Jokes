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
            .foregroundColor(Color("text"))
            .font(Font.system(size: 24, design: .rounded))
    }
}

struct HeadingLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("text"))
            .font(Font.system(size: 28, weight: .heavy, design: .rounded))
    }
}
