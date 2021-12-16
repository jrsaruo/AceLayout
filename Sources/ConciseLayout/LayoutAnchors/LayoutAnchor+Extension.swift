//
//  File.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/15.
//

import UIKit

extension LayoutAnchor where BaseLayoutAnchor == NSLayoutXAxisAnchor {
    
    @available(iOS 11.0, tvOS 11.0, *)
    @inlinable
    func equal(toSystemSpacingAfter anotherAnchor: BaseLayoutAnchor,
               multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
        anchor.constraint(equalToSystemSpacingAfter: anotherAnchor, multiplier: multiplier)
    }
    
    @available(iOS 11.0, tvOS 11.0, *)
    @inlinable
    func lessThanOrEqual(toSystemSpacingAfter anotherAnchor: BaseLayoutAnchor,
                         multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualToSystemSpacingAfter: anotherAnchor, multiplier: multiplier)
    }
}

extension LayoutAnchor where BaseLayoutAnchor == NSLayoutYAxisAnchor {
    
    @available(iOS 11.0, tvOS 11.0, *)
    @inlinable
    func equal(toSystemSpacingBelow anotherAnchor: BaseLayoutAnchor,
               multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
        anchor.constraint(equalToSystemSpacingBelow: anotherAnchor, multiplier: multiplier)
    }
    
    @available(iOS 11.0, tvOS 11.0, *)
    @inlinable
    func lessThanOrEqual(toSystemSpacingBelow anotherAnchor: BaseLayoutAnchor,
                         multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualToSystemSpacingBelow: anotherAnchor, multiplier: multiplier)
    }
}
