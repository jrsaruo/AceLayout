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

/// A type that represents a layout anchor for creating vertical layout constraints.
public protocol YAxisAnchor: LayoutAnchor where AnchorType == NSLayoutYAxisAnchor,
                                                BaseLayoutAnchor == NSLayoutYAxisAnchor,
                                                Target == any YAxesConstrainable {}

extension YAxisAnchor {
    
    // MARK: - Constraints with YAxesConstrainable
    
    /// Returns a constraint of the form `self` y == `another` y + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.top == anotherView.top
    ///     item.top.equal(to: anotherView)
    ///
    ///     // view.bottom == layoutGuide.bottom + 16
    ///     item.bottom.equal(to: layoutGuide, plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``YAxesConstrainable`` protocol
    ///              such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` y == `another` y + `offset`.
    @inlinable
    public func equal(
        to another: some YAxesConstrainable,
        plus offset: CGFloat = 0
    ) -> NSLayoutConstraint {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    /// Returns a constraint of the form `self` y <= `another` y + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.top <= anotherView.top
    ///     item.top.lessThanOrEqual(to: anotherView)
    ///
    ///     // view.bottom <= layoutGuide.bottom + 16
    ///     item.bottom.lessThanOrEqual(to: layoutGuide, plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``YAxesConstrainable`` protocol
    ///              such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` y <= `another` y + `offset`.
    @inlinable
    public func lessThanOrEqual(
        to another: some YAxesConstrainable,
        plus offset: CGFloat = 0
    ) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    /// Returns a constraint of the form `self` y >= `another` y + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.top >= anotherView.top
    ///     item.top.greaterThanOrEqual(to: anotherView)
    ///
    ///     // view.bottom >= layoutGuide.bottom + 16
    ///     item.bottom.greaterThanOrEqual(to: layoutGuide, plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``YAxesConstrainable`` protocol
    ///              such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` y >= `another` y + `offset`.
    @inlinable
    public func greaterThanOrEqual(
        to another: some YAxesConstrainable,
        plus offset: CGFloat = 0
    ) -> NSLayoutConstraint {
        anchor.constraint(greaterThanOrEqualTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    // MARK: - Constraints with superview
    
    /// Returns a constraint of the form `self` y == `superview` y + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.top == superview.top
    ///     item.top.equalToSuperview()
    ///
    ///     // view.bottom == superview.bottom + 16
    ///     item.bottom.equalToSuperview(plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` y == `superview` y + `offset`.
    public func equalToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure(
                "The layout target must have a superview before making constraints on it."
            )
        }
        return equal(to: superview, plus: offset)
    }
    
    /// Returns a constraint of the form `self` y <= `superview` y + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.top <= superview.top
    ///     item.top.lessThanOrEqualToSuperview()
    ///
    ///     // view.bottom <= superview.bottom + 16
    ///     item.bottom.lessThanOrEqualToSuperview(plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` y <= `superview` y + `offset`.
    public func lessThanOrEqualToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure(
                "The layout target must have a superview before making constraints on it."
            )
        }
        return lessThanOrEqual(to: superview, plus: offset)
    }
    
    /// Returns a constraint of the form `self` y >= `superview` y + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.top >= superview.top
    ///     item.top.greaterThanOrEqualToSuperview()
    ///
    ///     // view.bottom >= superview.bottom + 16
    ///     item.bottom.greaterThanOrEqualToSuperview(plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` y >= `superview` y + `offset`.
    public func greaterThanOrEqualToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure(
                "The layout target must have a superview before making constraints on it."
            )
        }
        return greaterThanOrEqual(to: superview, plus: offset)
    }
}
