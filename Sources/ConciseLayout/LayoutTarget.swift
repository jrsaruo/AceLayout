//
//  LayoutTarget.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/04.
//

import UIKit

public protocol LayoutTarget {
    associatedtype LayoutBase
    func autoLayout(activates: Bool,
                    @LayoutConstraintsBuilder builder: (LayoutItem<LayoutBase>) -> [NSLayoutConstraint]) -> [NSLayoutConstraint]
}

extension LayoutTarget where LayoutBase == Self {
    
    /// Default implement of `autoLayout(activates:, builder:)`.
    /// - Parameters:
    ///   - activates: Whether to immediately activate built constraints.
    ///   - builder: AutoLayout constraints builder.
    /// - Returns: Built constraints.
    fileprivate func _autoLayout(activates: Bool,
                                 @LayoutConstraintsBuilder builder: (LayoutItem<LayoutBase>) -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        let constraints = builder(LayoutItem(base: self))
        if activates {
            NSLayoutConstraint.activate(constraints)
        }
        return constraints
    }
    
    @discardableResult
    public func autoLayout(activates: Bool = true,
                           @LayoutConstraintsBuilder builder: (LayoutItem<LayoutBase>) -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        _autoLayout(activates: activates, builder: builder)
    }
}

extension UIView: LayoutTarget {
    
    @discardableResult
    public func autoLayout(activates: Bool = true,
                           @LayoutConstraintsBuilder builder: (LayoutItem<UIView>) -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        return _autoLayout(activates: activates, builder: builder)
    }
}

extension UILayoutGuide: LayoutTarget {
    public typealias LayoutBase = UILayoutGuide
}
