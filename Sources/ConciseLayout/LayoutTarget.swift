//
//  LayoutTarget.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/04.
//

import UIKit

public protocol LayoutTarget {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    
    func autoLayout(activates: Bool,
                    @LayoutConstraintsBuilder builder: (LayoutItem) -> [NSLayoutConstraint]) -> [NSLayoutConstraint]
}

extension LayoutTarget {
    
    /// Default implement of `autoLayout(activates:, builder:)`.
    /// - Parameters:
    ///   - activates: Whether to immediately activate built constraints.
    ///   - builder: AutoLayout constraints builder.
    /// - Returns: Built constraints.
    fileprivate func _autoLayout(activates: Bool,
                                 @LayoutConstraintsBuilder builder: (LayoutItem) -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        let constraints = builder(LayoutItem(self))
        if activates {
            NSLayoutConstraint.activate(constraints)
        }
        return constraints
    }
    
    @discardableResult
    public func autoLayout(activates: Bool = true,
                           @LayoutConstraintsBuilder builder: (LayoutItem) -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        _autoLayout(activates: activates, builder: builder)
    }
}

extension UIView: LayoutTarget {
    
    @discardableResult
    public func autoLayout(activates: Bool = true,
                           @LayoutConstraintsBuilder builder: (LayoutItem) -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        return _autoLayout(activates: activates, builder: builder)
    }
}

extension UILayoutGuide: LayoutTarget {}
