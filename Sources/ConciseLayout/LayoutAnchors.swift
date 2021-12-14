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
    
    func equal(to another: Target, plus offset: CGFloat) -> NSLayoutConstraint
    func equal(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat) -> NSLayoutConstraint
    func equal(to another: Self, plus offset: CGFloat) -> NSLayoutConstraint
    
    func equalToSuperview(plus offset: CGFloat) -> NSLayoutConstraint
}

extension LayoutAnchor {
    @usableFromInline var anchor: BaseLayoutAnchor { target[keyPath: anchorKeyPath] }
    
    public func equal(to another: Target, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    public func equal(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(equalTo: anotherAnchor, constant: offset)
    }
    
    public func equal(to another: Self, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(equalTo: another.anchor, constant: offset)
    }
}

extension LayoutAnchor where Target == XAxesConstrainable {
    
    public func equalToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return equal(to: superview, plus: offset)
    }
}

extension LayoutAnchor where Target == YAxesConstrainable {
    
    public func equalToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return equal(to: superview, plus: offset)
    }
}

extension LayoutAnchor where Target == DimensionsConstrainable {
    
    public func equalToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return equal(to: superview, plus: offset)
    }
}

extension LayoutAnchor where Target == BaselinesConstrainable {
    
    public func equalToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return equal(to: superview, plus: offset)
    }
}

/// Namespace for layout anchors.
public enum LayoutRect {
    
    public struct XAxis: LayoutAnchor {
        public typealias AnchorType = NSLayoutXAxisAnchor
        public let target: XAxesConstrainable
        public let anchorKeyPath: KeyPath<XAxesConstrainable, NSLayoutXAxisAnchor>
        
        @available(iOS 11.0, tvOS 11.0, *)
        @inlinable
        func equal(toSystemSpacingAfter anotherAnchor: BaseLayoutAnchor,
                   multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
            anchor.constraint(equalToSystemSpacingAfter: anotherAnchor, multiplier: multiplier)
        }
    }
    
    public struct YAxis: LayoutAnchor {
        public typealias AnchorType = NSLayoutYAxisAnchor
        public let target: YAxesConstrainable
        public let anchorKeyPath: KeyPath<YAxesConstrainable, NSLayoutYAxisAnchor>
        
        @available(iOS 11.0, tvOS 11.0, *)
        @inlinable
        func equal(toSystemSpacingBelow anotherAnchor: BaseLayoutAnchor,
                   multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
            anchor.constraint(equalToSystemSpacingBelow: anotherAnchor, multiplier: multiplier)
        }
    }
    
    public struct Dimension: LayoutAnchor {
        public typealias AnchorType = NSLayoutDimension
        public let target: DimensionsConstrainable
        public let anchorKeyPath: KeyPath<DimensionsConstrainable, NSLayoutDimension>
        
        public func equal(to constant: CGFloat) -> NSLayoutConstraint {
            anchor.constraint(equalToConstant: constant)
        }
    }
}

extension LayoutRect {
    
    public struct Point {
        var x: XAxis
        var y: YAxis
        
        public func equal<Target>(to another: Target) -> [NSLayoutConstraint] where Target: XYAxesConstrainable {
            [
                x.equal(to: another),
                y.equal(to: another)
            ]
        }
        
        public func equalToSuperview() -> [NSLayoutConstraint] {
            [
                x.equalToSuperview(),
                y.equalToSuperview()
            ]
        }
    }
    
    public struct Size {
        var width: Dimension
        var height: Dimension
        
        public func equal<Another>(to another: Another) -> [NSLayoutConstraint] where Another: DimensionsConstrainable {
            [
                width.equal(to: another),
                height.equal(to: another)
            ]
        }
        
        public func equal(to size: CGSize) -> [NSLayoutConstraint] {
            [
                width.equal(to: size.width),
                height.equal(to: size.height)
            ]
        }
        
        public func equal(toSquare sideLength: CGFloat) -> [NSLayoutConstraint] {
            [
                width.equal(to: sideLength),
                height.equal(to: sideLength)
            ]
        }
        
        public func equalToSuperview() -> [NSLayoutConstraint] {
            [
                width.equalToSuperview(),
                height.equalToSuperview()
            ]
        }
    }
    
    public struct Edges {
        var top: YAxis
        var left: XAxis
        var right: XAxis
        var bottom: YAxis
        
        public func equal<Another>(to another: Another,
                                   inside insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            [
                top.equal(to: another, plus: insets.top),
                left.equal(to: another, plus: insets.left),
                right.equal(to: another, plus: -insets.right),
                bottom.equal(to: another, plus: -insets.bottom)
            ]
        }
        
        @inlinable
        public func equal<Another>(to another: Another,
                                   inside inset: CGFloat) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            equal(to: another, inside: .init(top: inset, left: inset, bottom: inset, right: inset))
        }
        
        public func equalToSuperview(inside insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
            [
                top.equalToSuperview(plus: insets.top),
                left.equalToSuperview(plus: insets.left),
                right.equalToSuperview(plus: -insets.right),
                bottom.equalToSuperview(plus: -insets.bottom)
            ]
        }
        
        @inlinable
        public func equalToSuperview(inside inset: CGFloat) -> [NSLayoutConstraint] {
            equalToSuperview(inside: .init(top: inset, left: inset, bottom: inset, right: inset))
        }
    }
}
