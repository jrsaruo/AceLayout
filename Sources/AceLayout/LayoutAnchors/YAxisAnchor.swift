//
//  YAxisAnchor.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/14.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public protocol YAxisAnchor: LayoutAnchor where AnchorType == NSLayoutYAxisAnchor,
                                                BaseLayoutAnchor == NSLayoutYAxisAnchor,
                                                Target == YAxesConstrainable {}

extension YAxisAnchor {
    
    // MARK: - Constraints with XAxesConstrainable
    
    @inlinable
    public func equal<Another>(to another: Another,
                               plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: YAxesConstrainable {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    @inlinable
    public func lessThanOrEqual<Another>(to another: Another,
                                         plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: YAxesConstrainable {
        anchor.constraint(lessThanOrEqualTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    @inlinable
    public func greaterThanOrEqual<Another>(to another: Another,
                                            plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: YAxesConstrainable {
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
