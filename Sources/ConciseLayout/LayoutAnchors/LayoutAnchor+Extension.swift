//
//  File.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/15.
//

import UIKit

@available(iOS 11.0, tvOS 11.0, *)
extension LayoutAnchor where BaseLayoutAnchor == NSLayoutXAxisAnchor {
    
    @inlinable
    func equal(toSystemSpacingAfter anotherAnchor: BaseLayoutAnchor,
               multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
        anchor.constraint(equalToSystemSpacingAfter: anotherAnchor, multiplier: multiplier)
    }
    
    @inlinable
    func lessThanOrEqual(toSystemSpacingAfter anotherAnchor: BaseLayoutAnchor,
                         multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualToSystemSpacingAfter: anotherAnchor, multiplier: multiplier)
    }
    
    @inlinable
    func greaterThanOrEqual(toSystemSpacingAfter anotherAnchor: BaseLayoutAnchor,
                            multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
        anchor.constraint(greaterThanOrEqualToSystemSpacingAfter: anotherAnchor, multiplier: multiplier)
    }
}

@available(iOS 11.0, tvOS 11.0, *)
extension LayoutAnchor where BaseLayoutAnchor == NSLayoutYAxisAnchor {
    
    @inlinable
    func equal(toSystemSpacingBelow anotherAnchor: BaseLayoutAnchor,
               multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
        anchor.constraint(equalToSystemSpacingBelow: anotherAnchor, multiplier: multiplier)
    }
    
    @inlinable
    func lessThanOrEqual(toSystemSpacingBelow anotherAnchor: BaseLayoutAnchor,
                         multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualToSystemSpacingBelow: anotherAnchor, multiplier: multiplier)
    }
    
    @inlinable
    func greaterThanOrEqual(toSystemSpacingBelow anotherAnchor: BaseLayoutAnchor,
                            multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
        anchor.constraint(greaterThanOrEqualToSystemSpacingBelow: anotherAnchor, multiplier: multiplier)
    }
}
