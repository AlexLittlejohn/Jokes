//
//  Rotation.swift
//  Jokes
//
//  Created by Alex Littlejohn on 01/08/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import SwiftUI

enum Rotation {
    case zero
    case random
    
    var value: Angle {
        switch self {
        case .zero:
            return Angle(degrees: 0)
        case .random:
            return Angle(degrees: Double.random(in: -360...360))
        }
    }
    
    func next() -> Rotation {
        switch self {
        case .zero:
            return .random
        case .random:
            return .zero
        }
    }
}
