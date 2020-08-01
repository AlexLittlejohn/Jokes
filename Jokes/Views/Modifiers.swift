//
//  Modifiers.swift
//  Jokes
//
//  Created by Alex Littlejohn on 10/07/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    
    let color: Color
    var square: Bool = true
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal, Measurements.medium)
            .padding(.vertical, Measurements.small + Measurements.smaller)
            .font(Font.system(size: 18, weight: .semibold))
            .foregroundColor(Color("button_text"))
            .frame(minHeight: 48)
            .aspectRatio(square ? 1 : nil, contentMode: .fit)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: Measurements.medium, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct ScalingButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
