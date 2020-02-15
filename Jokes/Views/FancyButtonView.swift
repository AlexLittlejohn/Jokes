//
//  FancyButtonView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 15/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import SwiftUI

struct FancyButtonView: View {
    
    let action: () -> Void
    let title: String
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Font.headline)
                .foregroundColor(Color("the_color"))
                .padding()
                .background(Color.white)
                .clipShape(Capsule())
            
        }
    }
}
