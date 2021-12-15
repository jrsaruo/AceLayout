//
//  LayoutDimension.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/14.
//

import UIKit

public protocol LayoutDimension: LayoutAnchor where AnchorType == NSLayoutDimension,
                                                    BaseLayoutAnchor == NSLayoutDimension,
                                                    Target == SizeConstrainable {}

extension LayoutDimension {
    
    @inlinable
    public func equal<Another>(to another: Another,
                               plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: SizeConstrainable {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    @inlinable
    public func equal<Another>(to another: Another,
                               multipliedBy multiplier: CGFloat) -> NSLayoutConstraint where Another: SizeConstrainable {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], multiplier: multiplier)
    }
    
    @inlinable
    public func equal(to constant: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(equalToConstant: constant)
    }
    
    public func equalToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return equal(to: superview, plus: offset)
    }
}
