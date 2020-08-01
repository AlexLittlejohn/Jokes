//
//  Then.swift
//  Jokes
//
//  Created by Alex Littlejohn on 16/05/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit.UIGeometry

public protocol Then {}

extension Then where Self: Any {
    @inlinable
    func then(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}

extension Then where Self: AnyObject {
    @inlinable
    public func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension NSObject: Then {}
extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
extension Array: Then {}
extension Dictionary: Then {}
extension Set: Then {}
extension UIEdgeInsets: Then {}
extension NSDirectionalEdgeInsets: Then {}
