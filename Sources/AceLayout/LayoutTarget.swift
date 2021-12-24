//
//  LayoutTarget.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/04.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// A type that represents layout target such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
public protocol LayoutTarget {
    /// A type that represents layout target such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    /// This is equal to `Self`.
    associatedtype LayoutBase where LayoutBase == Self
    
    func autoLayout(activates: Bool,
                    @LayoutConstraintsBuilder builder: (LayoutItem<LayoutBase>) -> [NSLayoutConstraint]) -> [NSLayoutConstraint]
}

extension LayoutTarget {
    
    /// The default implementation of `autoLayout(activates:, builder:)`.
    /// - Parameters:
    ///   - activates: Whether to immediately activate constraints after building.
    ///   - builder: A layout constraints builder that creates constraints on the specified item.
    /// - Returns: An array of built `NSLayoutConstraint` objects.
    fileprivate func _autoLayout(activates: Bool,
                                 @LayoutConstraintsBuilder builder: (LayoutItem<Self>) -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        let constraints = builder(LayoutItem(base: self))
        if activates {
            NSLayoutConstraint.activate(constraints)
        }
        return constraints
    }
    
    /// Creates layout constraints.
    ///
    /// The ``LayoutItem`` instance passed to the `builder` has various layout anchors, and you can use them to create layout constraints.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     item.center.equalToSuperview()
    ///     item.size.equal(to: referenceView)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - activates: Whether to immediately activate constraints after building. The default value is `true`.
    ///   - builder: A layout constraints builder that creates constraints on the specified item.
    /// - Returns: An array of built `NSLayoutConstraint` objects.
    @discardableResult
    public func autoLayout(activates: Bool = true,
                           @LayoutConstraintsBuilder builder: (LayoutItem<Self>) -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        _autoLayout(activates: activates, builder: builder)
    }
}

extension AL.View: LayoutTarget {
    
    /// Creates layout constraints.
    ///
    /// The ``LayoutItem`` instance passed to the `builder` has various layout anchors, and you can use them to create layout constraints.
    ///
    /// ```
    /// view.autoLayout { item in
    ///     item.center.equalToSuperview()
    ///     item.size.equal(to: referenceView)
    /// }
    /// ```
    ///
    /// - Note: This method automatically sets `translatesAutoresizingMaskIntoConstraints` to `false`.
    /// - Parameters:
    ///   - activates: Whether to immediately activate constraints after building. The default value is `true`.
    ///   - builder: A layout constraints builder that creates constraints on the specified item.
    /// - Returns: An array of built `NSLayoutConstraint` objects.
    @discardableResult
    public func autoLayout(activates: Bool = true,
                           @LayoutConstraintsBuilder builder: (LayoutItem<AL.View>) -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        return _autoLayout(activates: activates, builder: builder)
    }
}

extension AL.LayoutGuide: LayoutTarget {}
