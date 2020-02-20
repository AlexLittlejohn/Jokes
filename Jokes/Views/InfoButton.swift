//
//  InfoButton.swift
//  Jokes
//
//  Created by Alex Littlejohn on 20/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import SwiftUI

struct InfoButtonView: View {
    
    let action: () -> Void
    let title: String
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "info.circle.fill")
                .accessibility(hint: Text(title))
                .foregroundColor(.white).padding()
        }
    }
}
