//
//  BaselineAnchor.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/15.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public protocol BaselineAnchor: LayoutAnchor where AnchorType == NSLayoutYAxisAnchor,
                                                   BaseLayoutAnchor == NSLayoutYAxisAnchor,
                                                   Target == BaselinesConstrainable {}

extension BaselineAnchor {
    
    // MARK: - Constraints with BaselinesConstrainable
    
    @inlinable
    public func equal<Another>(to another: Another,
                               plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: BaselinesConstrainable {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    @inlinable
    public func lessThanOrEqual<Another>(to another: Another,
                                         plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: BaselinesConstrainable {
        anchor.constraint(lessThanOrEqualTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    @inlinable
    public func greaterThanOrEqual<Another>(to another: Another,
                                            plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: BaselinesConstrainable {
        anchor.constraint(greaterThanOrEqualTo: another[keyPath: anchorKeyPath], constant: offset)
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
}
