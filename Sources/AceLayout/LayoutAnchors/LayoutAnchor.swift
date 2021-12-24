//
//  LayoutAnchors.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/04.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// A type that represents a layout anchor for creating constraints.
public protocol LayoutAnchor {
    associatedtype AnchorType: AnyObject
    associatedtype BaseLayoutAnchor: NSLayoutAnchor<AnchorType>
    
    /// A type of the layout target such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    associatedtype Target
    
    /// A layout target such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    var target: Target { get }
    
    /// A key path from the layout target to the base layout anchor.
    var anchorKeyPath: KeyPath<Target, BaseLayoutAnchor> { get }
    
    // MARK: - Constraints with BaseLayoutAnchor
    
    func equal(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat) -> NSLayoutConstraint
    func lessThanOrEqual(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat) -> NSLayoutConstraint
    func greaterThanOrEqual(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat) -> NSLayoutConstraint
    
    // MARK: - Constraints with LayoutAnchor
    
    func equal(to another: Self, plus offset: CGFloat) -> NSLayoutConstraint
    func lessThanOrEqual(to another: Self, plus offset: CGFloat) -> NSLayoutConstraint
    func greaterThanOrEqual(to another: Self, plus offset: CGFloat) -> NSLayoutConstraint
    
    // MARK: - Constraints with superview
    
    func equalToSuperview(plus offset: CGFloat) -> NSLayoutConstraint
    func lessThanOrEqualToSuperview(plus offset: CGFloat) -> NSLayoutConstraint
    func greaterThanOrEqualToSuperview(plus offset: CGFloat) -> NSLayoutConstraint
}

// MARK: - Default implementations -

extension LayoutAnchor {
    @usableFromInline var anchor: BaseLayoutAnchor { target[keyPath: anchorKeyPath] }
    
    // MARK: - Constraints with BaseLayoutAnchor
    
    /// Returns a constraint of the form `self` anchor == `anotherAnchor` + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // LayoutRect.XAxis to NSLayoutXAxisAnchor
    ///     item.leading.equal(to: anotherView.trailingAnchor)
    ///
    ///     // LayoutRect.Dimension to NSLayoutDimension
    ///     item.width.equal(to: layoutGuide.heightAnchor, plus: 8)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - anotherAnchor: A layout anchor from a `UIView`, `UILayoutGuide`, `NSView`, or `NSLayoutGuide` object. You must use a subclass of `NSLayoutAnchor` that matches the current anchor. For example, if you call this method on a `LayoutRect.XAxis`, this parameter must be `NSLayoutXAxisAnchor`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` anchor == `anotherAnchor` + `offset`.
    @inlinable
    public func equal(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(equalTo: anotherAnchor, constant: offset)
    }
    
    /// Returns a constraint of the form `self` anchor <= `anotherAnchor` + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // LayoutRect.XAxis to NSLayoutXAxisAnchor
    ///     item.leading.lessThanOrEqual(to: anotherView.trailingAnchor)
    ///
    ///     // LayoutRect.Dimension to NSLayoutDimension
    ///     item.width.lessThanOrEqual(to: layoutGuide.heightAnchor, plus: 8)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - anotherAnchor: A layout anchor from a `UIView`, `UILayoutGuide`, `NSView`, or `NSLayoutGuide` object. You must use a subclass of `NSLayoutAnchor` that matches the current anchor. For example, if you call this method on a `LayoutRect.XAxis`, this parameter must be `NSLayoutXAxisAnchor`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` anchor <= `anotherAnchor` + `offset`.
    @inlinable
    public func lessThanOrEqual(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualTo: anotherAnchor, constant: offset)
    }
    
    /// Returns a constraint of the form `self` anchor >= `anotherAnchor` + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // LayoutRect.XAxis to NSLayoutXAxisAnchor
    ///     item.leading.greaterThanOrEqual(to: anotherView.trailingAnchor)
    ///
    ///     // LayoutRect.Dimension to NSLayoutDimension
    ///     item.width.greaterThanOrEqual(to: layoutGuide.heightAnchor, plus: 8)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - anotherAnchor: A layout anchor from a `UIView`, `UILayoutGuide`, `NSView`, or `NSLayoutGuide` object. You must use a subclass of `NSLayoutAnchor` that matches the current anchor. For example, if you call this method on a `LayoutRect.XAxis`, this parameter must be `NSLayoutXAxisAnchor`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` anchor >= `anotherAnchor` + `offset`.
    @inlinable
    public func greaterThanOrEqual(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(greaterThanOrEqualTo: anotherAnchor, constant: offset)
    }
    
    // MARK: - Constraints with LayoutAnchor
    
    /// Returns a constraint of the form `self` anchor == `another` anchor + `offset`.
    ///
    /// A common use case is when creating Dimension constraints.
    /// ```
    /// view.autoLayout { item in
    ///     item.width.equal(to: item.height)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: A layout anchor from a ``LayoutItem``. You must use an instance of ``LayoutAnchor`` that matches the current anchor. For example, if you call this method on a `LayoutRect.Dimension`, this parameter must be `LayoutRect.Dimension`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` anchor == `another` anchor + `offset`.
    @inlinable
    public func equal(to another: Self, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(equalTo: another.anchor, constant: offset)
    }
    
    /// Returns a constraint of the form `self` anchor <= `another` anchor + `offset`.
    ///
    /// A common use case is when creating Dimension constraints.
    /// ```
    /// view.autoLayout { item in
    ///     item.width.lessThanOrEqual(to: item.height)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: A layout anchor from a ``LayoutItem``. You must use an instance of ``LayoutAnchor`` that matches the current anchor. For example, if you call this method on a `LayoutRect.Dimension`, this parameter must be `LayoutRect.Dimension`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` anchor <= `another` anchor + `offset`.
    @inlinable
    public func lessThanOrEqual(to another: Self, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualTo: another.anchor, constant: offset)
    }
    
    /// Returns a constraint of the form `self` anchor >= `another` anchor + `offset`.
    ///
    /// A common use case is when creating Dimension constraints.
    /// ```
    /// view.autoLayout { item in
    ///     item.width.greaterThanOrEqual(to: item.height)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: A layout anchor from a ``LayoutItem``. You must use an instance of ``LayoutAnchor`` that matches the current anchor. For example, if you call this method on a `LayoutRect.Dimension`, this parameter must be `LayoutRect.Dimension`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` anchor >= `another` anchor + `offset`.
    @inlinable
    public func greaterThanOrEqual(to another: Self, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(greaterThanOrEqualTo: another.anchor, constant: offset)
    }
}
