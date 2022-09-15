//
//  XAxisAnchor.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/14.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// A type that represents a layout anchor for creating horizontal layout constraints.
public protocol XAxisAnchor: LayoutAnchor where AnchorType == NSLayoutXAxisAnchor,
                                                BaseLayoutAnchor == NSLayoutXAxisAnchor,
                                                Target == XAxesConstrainable {}

extension XAxisAnchor {
    
    // MARK: - Constraints with XAxesConstrainable
    
    /// Returns a constraint of the form `self` x == `another` x + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.leading == anotherView.leading
    ///     item.leading.equal(to: anotherView)
    ///
    ///     // view.trailing == layoutGuide.trailing + 16
    ///     item.trailing.equal(to: layoutGuide, plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``XAxesConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` x == `another` x + `offset`.
    @inlinable
    public func equal(to another: some XAxesConstrainable,
                      plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    /// Returns a constraint of the form `self` x <= `another` x + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.leading <= anotherView.leading
    ///     item.leading.lessThanOrEqual(to: anotherView)
    ///
    ///     // view.trailing <= layoutGuide.trailing + 16
    ///     item.trailing.lessThanOrEqual(to: layoutGuide, plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``XAxesConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` x <= `another` x + `offset`.
    @inlinable
    public func lessThanOrEqual(to another: some XAxesConstrainable,
                                plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    /// Returns a constraint of the form `self` x >= `another` x + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.leading >= anotherView.leading
    ///     item.leading.greaterThanOrEqual(to: anotherView)
    ///
    ///     // view.trailing >= layoutGuide.trailing + 16
    ///     item.trailing.greaterThanOrEqual(to: layoutGuide, plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``XAxesConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` x >= `another` x + `offset`.
    @inlinable
    public func greaterThanOrEqual(to another: some XAxesConstrainable,
                                   plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(greaterThanOrEqualTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    // MARK: - Constraints with superview
    
    /// Returns a constraint of the form `self` x == `superview` x + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.leading == superview.leading
    ///     item.leading.equalToSuperview()
    ///
    ///     // view.trailing == superview.trailing + 16
    ///     item.trailing.equalToSuperview(plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` x == `superview` x + `offset`.
    public func equalToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return equal(to: superview, plus: offset)
    }
    
    /// Returns a constraint of the form `self` x <= `superview` x + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.leading <= superview.leading
    ///     item.leading.lessThanOrEqualToSuperview()
    ///
    ///     // view.trailing <= superview.trailing + 16
    ///     item.trailing.lessThanOrEqualToSuperview(plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` x <= `superview` x + `offset`.
    public func lessThanOrEqualToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return lessThanOrEqual(to: superview, plus: offset)
    }
    
    /// Returns a constraint of the form `self` x >= `superview` x + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.leading >= superview.leading
    ///     item.leading.greaterThanOrEqualToSuperview()
    ///
    ///     // view.trailing >= superview.trailing + 16
    ///     item.trailing.greaterThanOrEqualToSuperview(plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` x >= `superview` x + `offset`.
    public func greaterThanOrEqualToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return greaterThanOrEqual(to: superview, plus: offset)
    }
}
