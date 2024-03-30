//
//  LayoutAnchor+Extension.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/15.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

@available(iOS 11.0, macOS 11.0, tvOS 11.0, *)
extension LayoutAnchor where BaseLayoutAnchor == NSLayoutXAxisAnchor {
    
    /// Returns a constraint of the form `self` x == `anotherAnchor` + systemSpacing \* `multiplier`.
    ///
    /// The constraint causes the current anchor to trail the object in the `anotherAnchor` parameter. For example, in a left-to-right layout, the current anchor is to the right of `anotherAnchor`, but in a right-to-left layout, it is to the left of `anotherAnchor`.
    ///
    /// The distance between the two anchors is determined by multiplying the system spacing by the value in the `multiplier` parameter. The value of the system space is determined from information available from the anchors.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.leading == anotherView.trailing + systemSpacing
    ///     item.leading.equal(toSystemSpacingAfter: anotherView.trailingAnchor)
    ///
    ///     // view.leading == layoutGuide.trailing + systemSpacing * 2.0
    ///     item.leading.equal(toSystemSpacingAfter: layoutGuide.trailingAnchor, multipliedBy: 2.0)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - anotherAnchor: The X axis anchor to use as the starting point for the constraint.
    ///   - multiplier: The multiple of the system spacing to use as the distance between the two anchors. The default value is `1`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` x == `anotherAnchor` + systemSpacing \* `multiplier`.
    @inlinable
    public func equal(
        toSystemSpacingAfter anotherAnchor: BaseLayoutAnchor,
        multipliedBy multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        anchor.constraint(equalToSystemSpacingAfter: anotherAnchor, multiplier: multiplier)
    }
    
    /// Returns a constraint of the form `self` x <= `anotherAnchor` + systemSpacing \* `multiplier`.
    ///
    /// The constraint causes the current anchor to trail the object in the `anotherAnchor` parameter. For example, in a left-to-right layout, the current anchor is to the right of `anotherAnchor`, but in a right-to-left layout, it is to the left of `anotherAnchor`.
    ///
    /// The maximum distance between the two anchors is determined by multiplying the system spacing by the value in the `multiplier` parameter. (The actual distance must be less than or equal to that value.) The value of the system space is determined from information available from the anchors.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.leading <= anotherView.trailing + systemSpacing
    ///     item.leading.lessThanOrEqual(toSystemSpacingAfter: anotherView.trailingAnchor)
    ///
    ///     // view.leading <= layoutGuide.trailing + systemSpacing * 2.0
    ///     item.leading.lessThanOrEqual(toSystemSpacingAfter: layoutGuide.trailingAnchor, multipliedBy: 2.0)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - anotherAnchor: The X axis anchor to use as the starting point for the constraint.
    ///   - multiplier: The multiple of the system spacing to use as the maximum distance between the two anchors. The default value is `1`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` x <= `anotherAnchor` + systemSpacing \* `multiplier`.
    @inlinable
    public func lessThanOrEqual(
        toSystemSpacingAfter anotherAnchor: BaseLayoutAnchor,
        multipliedBy multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        anchor.constraint(
            lessThanOrEqualToSystemSpacingAfter: anotherAnchor,
            multiplier: multiplier
        )
    }
    
    /// Returns a constraint of the form `self` x >= `anotherAnchor` + systemSpacing \* `multiplier`.
    ///
    /// The constraint causes the current anchor to trail the object in the `anotherAnchor` parameter. For example, in a left-to-right layout, the current anchor is to the right of `anotherAnchor`, but in a right-to-left layout, it is to the left of `anotherAnchor`.
    ///
    /// The minimum distance between the two anchors is determined by multiplying the system spacing by the value in the `multiplier` parameter. (The actual distance must be greater than or equal to that value.) The value of the system space is determined from information available from the anchors.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.leading >= anotherView.trailing + systemSpacing
    ///     item.leading.greaterThanOrEqual(toSystemSpacingAfter: anotherView.trailingAnchor)
    ///
    ///     // view.leading >= layoutGuide.trailing + systemSpacing * 2.0
    ///     item.leading.greaterThanOrEqual(toSystemSpacingAfter: layoutGuide.trailingAnchor, multipliedBy: 2.0)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - anotherAnchor: The X axis anchor to use as the starting point for the constraint.
    ///   - multiplier: The multiple of the system spacing to use as the minimum distance between the two anchors. The default value is `1`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` x >= `anotherAnchor` + systemSpacing \* `multiplier`.
    @inlinable
    public func greaterThanOrEqual(
        toSystemSpacingAfter anotherAnchor: BaseLayoutAnchor,
        multipliedBy multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        anchor.constraint(
            greaterThanOrEqualToSystemSpacingAfter: anotherAnchor,
            multiplier: multiplier
        )
    }
}

@available(iOS 11.0, macOS 11.0, tvOS 11.0, *)
extension LayoutAnchor where BaseLayoutAnchor == NSLayoutYAxisAnchor {
    
    /// Returns a constraint of the form `self` y == `anotherAnchor` + systemSpacing \* `multiplier`.
    ///
    /// The constraint causes the current anchor to be positioned below the object in the `anotherAnchor` parameter.
    ///
    /// The distance between the two anchors is determined by multiplying the system spacing by the value in the `multiplier` parameter. The value of the system spacing is determined from information available from the anchors. For example, if the anchors represent text baselines, the spacing is determined by the fonts used at those baselines.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.top == anotherView.bottom + systemSpacing
    ///     item.top.equal(toSystemSpacingBelow: anotherView.bottomAnchor)
    ///
    ///     // view.top == layoutGuide.bottom + systemSpacing * 2.0
    ///     item.top.equal(toSystemSpacingBelow: layoutGuide.bottomAnchor, multipliedBy: 2.0)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - anotherAnchor: The Y axis anchor to use as the starting point for the constraint.
    ///   - multiplier: The multiple of the system spacing to use as the distance between the two anchors. The default value is `1`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` y == `anotherAnchor` + systemSpacing \* `multiplier`.
    @inlinable
    public func equal(
        toSystemSpacingBelow anotherAnchor: BaseLayoutAnchor,
        multipliedBy multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        anchor.constraint(equalToSystemSpacingBelow: anotherAnchor, multiplier: multiplier)
    }
    
    /// Returns a constraint of the form `self` y <= `anotherAnchor` + systemSpacing \* `multiplier`.
    ///
    /// The constraint causes the current anchor to be positioned below the object in the `anotherAnchor` parameter.
    ///
    /// The maximum distance between the two anchors is determined by multiplying the system spacing by the value in the `multiplier` parameter. The value of the system spacing is determined from information available from the anchors. For example, if the anchors represent text baselines, the spacing is determined by the fonts used at those baselines.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.top <= anotherView.bottom + systemSpacing
    ///     item.top.lessThanOrEqual(toSystemSpacingBelow: anotherView.bottomAnchor)
    ///
    ///     // view.top <= layoutGuide.bottom + systemSpacing * 2.0
    ///     item.top.lessThanOrEqual(toSystemSpacingBelow: layoutGuide.bottomAnchor, multipliedBy: 2.0)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - anotherAnchor: The Y axis anchor to use as the starting point for the constraint.
    ///   - multiplier: The multiple of the system spacing to use as the distance between the two anchors. The default value is `1`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` y <= `anotherAnchor` + systemSpacing \* `multiplier`.
    @inlinable
    public func lessThanOrEqual(
        toSystemSpacingBelow anotherAnchor: BaseLayoutAnchor,
        multipliedBy multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        anchor.constraint(
            lessThanOrEqualToSystemSpacingBelow: anotherAnchor,
            multiplier: multiplier
        )
    }
    
    /// Returns a constraint of the form `self` y >= `anotherAnchor` + systemSpacing \* `multiplier`.
    ///
    /// The constraint causes the current anchor to be positioned below the object in the `anotherAnchor` parameter.
    ///
    /// The minimum distance between the two anchors is determined by multiplying the system spacing by the value in the `multiplier` parameter. The value of the system spacing is determined from information available from the anchors. For example, if the anchors represent text baselines, the spacing is determined by the fonts used at those baselines.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.top >= anotherView.bottom + systemSpacing
    ///     item.top.greaterThanOrEqual(toSystemSpacingBelow: anotherView.bottomAnchor)
    ///
    ///     // view.top >= layoutGuide.bottom + systemSpacing * 2.0
    ///     item.top.greaterThanOrEqual(toSystemSpacingBelow: layoutGuide.bottomAnchor, multipliedBy: 2.0)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - anotherAnchor: The Y axis anchor to use as the starting point for the constraint.
    ///   - multiplier: The multiple of the system spacing to use as the distance between the two anchors. The default value is `1`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` y >= `anotherAnchor` + systemSpacing \* `multiplier`.
    @inlinable
    public func greaterThanOrEqual(
        toSystemSpacingBelow anotherAnchor: BaseLayoutAnchor,
        multipliedBy multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        anchor.constraint(
            greaterThanOrEqualToSystemSpacingBelow: anotherAnchor,
            multiplier: multiplier
        )
    }
}
