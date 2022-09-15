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

/// A type that represents a layout anchor for creating size-based layout constraints.
public protocol LayoutDimension: LayoutAnchor where AnchorType == NSLayoutDimension,
                                                    BaseLayoutAnchor == NSLayoutDimension,
                                                    Target == any SizeConstrainable {}

extension LayoutDimension {
    
    // MARK: - Constraints with SizeConstrainable
    
    /// Returns a constraint of the form `self` dimension == `another` dimension + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width == anotherView.width
    ///     item.width.equal(to: anotherView)
    ///
    ///     // view.height == layoutGuide.height + 16
    ///     item.height.equal(to: layoutGuide, plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``SizeConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension == `another` dimension + `offset`.
    @inlinable
    public func equal(to another: some SizeConstrainable,
                      plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    /// Returns a constraint of the form `self` dimension <= `another` dimension + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width <= anotherView.width
    ///     item.width.lessThanOrEqual(to: anotherView)
    ///
    ///     // view.height <= layoutGuide.height + 16
    ///     item.height.lessThanOrEqual(to: layoutGuide, plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``SizeConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension <= `another` dimension + `offset`.
    @inlinable
    public func lessThanOrEqual(to another: some SizeConstrainable,
                                plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    /// Returns a constraint of the form `self` dimension >= `another` dimension + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width >= anotherView.width
    ///     item.width.greaterThanOrEqual(to: anotherView)
    ///
    ///     // view.height >= layoutGuide.height + 16
    ///     item.height.greaterThanOrEqual(to: layoutGuide, plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``SizeConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension >= `another` dimension + `offset`.
    @inlinable
    public func greaterThanOrEqual(to another: some SizeConstrainable,
                                   plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(greaterThanOrEqualTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    /// Returns a constraint of the form `self` dimension == `another` dimension \* `multiplier`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width == anotherView.width * 1.5
    ///     item.width.equal(to: anotherView, multipliedBy: 1.5)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``SizeConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    ///   - multiplier: The multiplier constant for the constraint.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension == `another` dimension \* `multiplier`.
    @inlinable
    public func equal(to another: some SizeConstrainable,
                      multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], multiplier: multiplier)
    }
    
    /// Returns a constraint of the form `self` dimension <= `another` dimension \* `multiplier`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width <= anotherView.width * 1.5
    ///     item.width.lessThanOrEqual(to: anotherView, multipliedBy: 1.5)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``SizeConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    ///   - multiplier: The multiplier constant for the constraint.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension <= `another` dimension \* `multiplier`.
    @inlinable
    public func lessThanOrEqual(to another: some SizeConstrainable,
                                multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualTo: another[keyPath: anchorKeyPath], multiplier: multiplier)
    }
    
    /// Returns a constraint of the form `self` dimension >= `another` dimension \* `multiplier`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width >= anotherView.width * 1.5
    ///     item.width.greaterThanOrEqual(to: anotherView, multipliedBy: 1.5)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``SizeConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    ///   - multiplier: The multiplier constant for the constraint.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension >= `another` dimension \* `multiplier`.
    @inlinable
    public func greaterThanOrEqual(to another: some SizeConstrainable,
                                   multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(greaterThanOrEqualTo: another[keyPath: anchorKeyPath], multiplier: multiplier)
    }
    
    // MARK: - Constraints with BaseLayoutAnchor
    
    /// Returns a constraint of the form `self` dimension == `anotherAnchor` \* `multiplier`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width == anotherView.height * 1.5
    ///     item.width.equal(to: anotherView.heightAnchor, multipliedBy: 1.5)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - anotherAnchor: An `NSLayoutDimension` object from a `UIView`, `UILayoutGuide`, `NSView`, or `NSLayoutGuide` object.
    ///   - multiplier: The multiplier constant for the constraint.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension == `anotherAnchor` \* `multiplier`.
    @inlinable
    public func equal(to anotherAnchor: BaseLayoutAnchor,
                      multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(equalTo: anotherAnchor, multiplier: multiplier)
    }
    
    /// Returns a constraint of the form `self` dimension <= `anotherAnchor` \* `multiplier`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width <= anotherView.height * 1.5
    ///     item.width.lessThanOrEqual(to: anotherView.heightAnchor, multipliedBy: 1.5)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - anotherAnchor: An `NSLayoutDimension` object from a `UIView`, `UILayoutGuide`, `NSView`, or `NSLayoutGuide` object.
    ///   - multiplier: The multiplier constant for the constraint.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension <= `anotherAnchor` \* `multiplier`.
    @inlinable
    public func lessThanOrEqual(to anotherAnchor: BaseLayoutAnchor,
                                multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualTo: anotherAnchor, multiplier: multiplier)
    }
    
    /// Returns a constraint of the form `self` dimension >= `anotherAnchor` \* `multiplier`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width >= anotherView.height * 1.5
    ///     item.width.greaterThanOrEqual(to: anotherView.heightAnchor, multipliedBy: 1.5)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - anotherAnchor: An `NSLayoutDimension` object from a `UIView`, `UILayoutGuide`, `NSView`, or `NSLayoutGuide` object.
    ///   - multiplier: The multiplier constant for the constraint.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension >= `anotherAnchor` \* `multiplier`.
    @inlinable
    public func greaterThanOrEqual(to anotherAnchor: BaseLayoutAnchor,
                                   multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(greaterThanOrEqualTo: anotherAnchor, multiplier: multiplier)
    }
    
    // MARK: - Constraints with LayoutDimension
    
    /// Returns a constraint of the form `self` dimension == `another` dimension \* `multiplier`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width == view.height * 1.5
    ///     item.width.equal(to: item.height, multipliedBy: 1.5)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: A layout anchor from a ``LayoutItem``. You must use an instance of ``LayoutDimension`` that matches the current anchor. For example, if you call this method on a `LayoutRect.Dimension`, this parameter must be `LayoutRect.Dimension`.
    ///   - multiplier: The multiplier constant for the constraint.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension == `another` dimension \* `multiplier`.
    @inlinable
    public func equal(to another: Self,
                      multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(equalTo: another.anchor, multiplier: multiplier)
    }
    
    /// Returns a constraint of the form `self` dimension <= `another` dimension \* `multiplier`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width <= view.height * 1.5
    ///     item.width.lessThanOrEqual(to: item.height, multipliedBy: 1.5)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: A layout anchor from a ``LayoutItem``. You must use an instance of ``LayoutDimension`` that matches the current anchor. For example, if you call this method on a `LayoutRect.Dimension`, this parameter must be `LayoutRect.Dimension`.
    ///   - multiplier: The multiplier constant for the constraint.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension <= `another` dimension \* `multiplier`.
    @inlinable
    public func lessThanOrEqual(to another: Self,
                                multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualTo: another.anchor, multiplier: multiplier)
    }
    
    /// Returns a constraint of the form `self` dimension >= `another` dimension \* `multiplier`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width >= view.height * 1.5
    ///     item.width.greaterThanOrEqual(to: item.height, multipliedBy: 1.5)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: A layout anchor from a ``LayoutItem``. You must use an instance of ``LayoutDimension`` that matches the current anchor. For example, if you call this method on a `LayoutRect.Dimension`, this parameter must be `LayoutRect.Dimension`.
    ///   - multiplier: The multiplier constant for the constraint.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension >= `another` dimension \* `multiplier`.
    @inlinable
    public func greaterThanOrEqual(to another: Self,
                                   multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(greaterThanOrEqualTo: another.anchor, multiplier: multiplier)
    }
    
    // MARK: - Constraints with constant
    
    /// Returns a constraint of the form `self` dimension == `constant`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width == 100
    ///     item.width.equal(to: 100)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - constant: A constant representing the size of the attribute associated with this dimension anchor.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension == `constant`.
    @inlinable
    public func equal(to constant: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(equalToConstant: constant)
    }
    
    /// Returns a constraint of the form `self` dimension <= `constant`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width <= 100
    ///     item.lessThanOrEqual.equal(to: 100)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - constant: A constant representing the maximum size of the attribute associated with this dimension anchor.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension <= `constant`.
    @inlinable
    public func lessThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualToConstant: constant)
    }
    
    /// Returns a constraint of the form `self` dimension >= `constant`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width >= 100
    ///     item.width.greaterThanOrEqual(to: 100)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - constant: A constant representing the minimum size of the attribute associated with this dimension anchor.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension >= `constant`.
    @inlinable
    public func greaterThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
        anchor.constraint(greaterThanOrEqualToConstant: constant)
    }
    
    // MARK: - Constraints with superview
    
    /// Returns a constraint of the form `self` dimension == `superview` dimension + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width == superview.width
    ///     item.width.equalToSuperview()
    ///
    ///     // view.height == superview.height + 16
    ///     item.height.equalToSuperview(plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension == `superview` dimension + `offset`.
    public func equalToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return equal(to: superview, plus: offset)
    }
    
    /// Returns a constraint of the form `self` dimension <= `superview` dimension + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width <= superview.width
    ///     item.width.lessThanOrEqualToSuperview()
    ///
    ///     // view.height <= superview.height + 16
    ///     item.height.lessThanOrEqualToSuperview(plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension <= `superview` dimension + `offset`.
    public func lessThanOrEqualToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return lessThanOrEqual(to: superview, plus: offset)
    }
    
    /// Returns a constraint of the form `self` dimension >= `superview` dimension + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width >= superview.width
    ///     item.width.greaterThanOrEqualToSuperview()
    ///
    ///     // view.height >= superview.height + 16
    ///     item.height.greaterThanOrEqualToSuperview(plus: 16)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension >= `superview` dimension + `offset`.
    public func greaterThanOrEqualToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return greaterThanOrEqual(to: superview, plus: offset)
    }
    
    /// Returns a constraint of the form `self` dimension == `superview` dimension \* `multiplier`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width == superview.width * 1.5
    ///     item.width.equalToSuperview(multipliedBy: 1.5)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - multiplier: The multiplier constant for the constraint.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension == `superview` dimension \* `multiplier`.
    public func equalToSuperview(multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return equal(to: superview, multipliedBy: multiplier)
    }
    
    /// Returns a constraint of the form `self` dimension <= `superview` dimension \* `multiplier`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width <= superview.width * 1.5
    ///     item.width.lessThanOrEqualToSuperview(multipliedBy: 1.5)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - multiplier: The multiplier constant for the constraint.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension <= `superview` dimension \* `multiplier`.
    public func lessThanOrEqualToSuperview(multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return lessThanOrEqual(to: superview, multipliedBy: multiplier)
    }
    
    /// Returns a constraint of the form `self` dimension >= `superview` dimension \* `multiplier`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.width >= superview.width * 1.5
    ///     item.width.greaterThanOrEqualToSuperview(multipliedBy: 1.5)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - multiplier: The multiplier constant for the constraint.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` dimension >= `superview` dimension \* `multiplier`.
    public func greaterThanOrEqualToSuperview(multipliedBy multiplier: CGFloat) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return greaterThanOrEqual(to: superview, multipliedBy: multiplier)
    }
}
