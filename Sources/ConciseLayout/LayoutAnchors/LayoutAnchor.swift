//
//  LayoutAnchors.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/04.
//

import UIKit

public protocol LayoutAnchor {
    associatedtype AnchorType: AnyObject
    associatedtype BaseLayoutAnchor: NSLayoutAnchor<AnchorType>
    associatedtype Target
    
    var target: Target { get }
    var anchorKeyPath: KeyPath<Target, BaseLayoutAnchor> { get }
    
    func equal(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat) -> NSLayoutConstraint
    func lessThanOrEqual(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat) -> NSLayoutConstraint
    
    func equal(to another: Self, plus offset: CGFloat) -> NSLayoutConstraint
    func lessThanOrEqual(to another: Self, plus offset: CGFloat) -> NSLayoutConstraint
    
    func equalToSuperview(plus offset: CGFloat) -> NSLayoutConstraint
    func lessThanOrEqualToSuperview(plus offset: CGFloat) -> NSLayoutConstraint
}

extension LayoutAnchor {
    @usableFromInline var anchor: BaseLayoutAnchor { target[keyPath: anchorKeyPath] }
    
    // MARK: - Constraints with BaseLayoutAnchor
    
    @inlinable
    public func equal(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(equalTo: anotherAnchor, constant: offset)
    }
    
    @inlinable
    public func lessThanOrEqual(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualTo: anotherAnchor, constant: offset)
    }
    
    // MARK: - Constraints with LayoutAnchor
    
    @inlinable
    public func equal(to another: Self, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(equalTo: another.anchor, constant: offset)
    }
    
    @inlinable
    public func lessThanOrEqual(to another: Self, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(lessThanOrEqualTo: another.anchor, constant: offset)
    }
}
