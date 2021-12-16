//
//  LayoutDimension.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/14.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public protocol LayoutDimension: LayoutAnchor where AnchorType == NSLayoutDimension,
                                                    BaseLayoutAnchor == NSLayoutDimension,
                                                    Target == SizeConstrainable {}

extension LayoutDimension {
    
    // MARK: - Constraints with SizeConstrainable
    
    @inlinable
    public func equal<Another>(to another: Another,
                               plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: SizeConstrainable {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    @inlinable
    public func lessThanOrEqual<Another>(to another: Another,
                                         plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: SizeConstrainable {
        anchor.constraint(lessThanOrEqualTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    @inlinable
    public func greaterThanOrEqual<Another>(to another: Another,
                                            plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: SizeConstrainable {
        anchor.constraint(greaterThanOrEqualTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    @inlinable
    public func equal<Another>(to another: Another,
                               multipliedBy multiplier: CGFloat) -> NSLayoutConstraint where Another: SizeConstrainable {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], multiplier: multiplier)
    }
    
    @inlinable
    public func lessThanOrEqual<Another>(to another: Another,
                                         multipliedBy multiplier: CGFloat) -> NSLayoutConstraint where Another: SizeConstrainable {
        anchor.constraint(lessThanOrEqualTo: another[keyPath: anchorKeyPath], multiplier: multiplier)
    }
    
    @inlinable
    public func greaterThanOrEqual<Another>(to another: Another,
                                            multipliedBy multiplier: CGFloat) -> NSLayoutConstraint where Another: SizeConstrainable {
        anchor.constraint(greaterThanOrEqualTo: another[keyPath: anchorKeyPath], multiplier: multiplier)
    }
    
    // MARK: - Constraints with constant
    
    @inlinable
    public func equal(to constant: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(equalToConstant: constant)
    }
    
    @inlinable
    public func lessThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualToConstant: constant)
    }
    
    @inlinable
    public func greaterThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(greaterThanOrEqualToConstant: constant)
    }
    
    // MARK: - Constraints with superview
    
    public func equalToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return equal(to: superview, plus: offset)
    }
    
    public func lessThanOrEqualToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return lessThanOrEqual(to: superview, plus: offset)
    }
    
    public func greaterThanOrEqualToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return greaterThanOrEqual(to: superview, plus: offset)
    }
    
    public func equalToSuperview(multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return equal(to: superview, multipliedBy: multiplier)
    }
    
    public func lessThanOrEqualToSuperview(multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return lessThanOrEqual(to: superview, multipliedBy: multiplier)
    }
    
    public func greaterThanOrEqualToSuperview(multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return greaterThanOrEqual(to: superview, multipliedBy: multiplier)
    }
}
