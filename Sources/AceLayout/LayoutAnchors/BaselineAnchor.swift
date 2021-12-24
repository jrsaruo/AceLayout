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

/// A type that represents a baseline layout anchor for creating vertical layout constraints.
public protocol BaselineAnchor: LayoutAnchor where AnchorType == NSLayoutYAxisAnchor,
                                                   BaseLayoutAnchor == NSLayoutYAxisAnchor,
                                                   Target == BaselinesConstrainable {}

extension BaselineAnchor {
    
    // MARK: - Constraints with BaselinesConstrainable
    
    /// Returns a constraint of the form `self` baseline == `another` baseline + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.firstBaseline == anotherView.firstBaseline
    ///     item.firstBaseline.equal(to: anotherView)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``BaselinesConstrainable`` protocol such as `UIView` or `NSView`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` baseline == `another` baseline + `offset`.
    @inlinable
    public func equal<Another>(to another: Another,
                               plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: BaselinesConstrainable {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    /// Returns a constraint of the form `self` baseline <= `another` baseline + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.firstBaseline <= anotherView.firstBaseline
    ///     item.firstBaseline.lessThanOrEqual(to: anotherView)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``BaselinesConstrainable`` protocol such as `UIView` or `NSView`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` baseline <= `another` baseline + `offset`.
    @inlinable
    public func lessThanOrEqual<Another>(to another: Another,
                                         plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: BaselinesConstrainable {
        anchor.constraint(lessThanOrEqualTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    /// Returns a constraint of the form `self` baseline >= `another` baseline + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.firstBaseline >= anotherView.firstBaseline
    ///     item.firstBaseline.greaterThanOrEqual(to: anotherView)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - another: An instance of the type that conforms to ``BaselinesConstrainable`` protocol such as `UIView` or `NSView`.
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` baseline >= `another` baseline + `offset`.
    @inlinable
    public func greaterThanOrEqual<Another>(to another: Another,
                                            plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: BaselinesConstrainable {
        anchor.constraint(greaterThanOrEqualTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    // MARK: - Constraints with superview
    
    /// Returns a constraint of the form `self` baseline == `superview` baseline + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.firstBaseline == superview.firstBaseline
    ///     item.firstBaseline.equalToSuperview()
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` baseline == `superview` baseline + `offset`.
    public func equalToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return equal(to: superview, plus: offset)
    }
    
    /// Returns a constraint of the form `self` baseline <= `superview` baseline + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.firstBaseline <= superview.firstBaseline
    ///     item.firstBaseline.lessThanOrEqualToSuperview()
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` baseline <= `superview` baseline + `offset`.
    public func lessThanOrEqualToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return lessThanOrEqual(to: superview, plus: offset)
    }
    
    /// Returns a constraint of the form `self` baseline >= `superview` baseline + `offset`.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     // view.firstBaseline >= superview.firstBaseline
    ///     item.firstBaseline.greaterThanOrEqualToSuperview()
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - offset: A constant offset for the constraint. The default value is `0`.
    /// - Returns: An  `NSLayoutConstraint` object that represents `self` baseline >= `superview` baseline + `offset`.
    public func greaterThanOrEqualToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return greaterThanOrEqual(to: superview, plus: offset)
    }
}
