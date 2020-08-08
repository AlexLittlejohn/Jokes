//
//  AnyTransition+MoveAndFade .swift
//  Jokes
//
//  Created by Alex Littlejohn on 08/08/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing).combined(with: .opacity)
        let removal = AnyTransition.move(edge: .leading).combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
