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
    
    var target: LayoutTarget { get }
    var keyPath: KeyPath<LayoutTarget, BaseLayoutAnchor> { get }
    
    func equal<Target>(to another: Target, plus offset: CGFloat) -> NSLayoutConstraint where Target: LayoutTarget
    func equal(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat) -> NSLayoutConstraint
    func equal(to another: Self, plus offset: CGFloat) -> NSLayoutConstraint
    
    func equalToSuperview(plus offset: CGFloat) -> NSLayoutConstraint
}

extension LayoutAnchor {
    @usableFromInline var anchor: BaseLayoutAnchor { target[keyPath: keyPath] }
    
    @inlinable
    public func equal<Target>(to another: Target, plus offset: CGFloat = 0) -> NSLayoutConstraint where Target: LayoutTarget {
        anchor.constraint(equalTo: another[keyPath: keyPath], constant: offset)
    }
    
    public func equal(to anotherAnchor: BaseLayoutAnchor, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(equalTo: anotherAnchor, constant: offset)
    }
    
    public func equal(to another: Self, plus offset: CGFloat = 0) -> NSLayoutConstraint {
        anchor.constraint(equalTo: another.anchor, constant: offset)
    }
    
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
        
        public let target: LayoutTarget
        public let keyPath: KeyPath<LayoutTarget, NSLayoutXAxisAnchor>
        
        @available(iOS 11.0, tvOS 11.0, *)
        @inlinable
        func equal(toSystemSpacingAfter anotherAnchor: BaseLayoutAnchor,
                   multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
            anchor.constraint(equalToSystemSpacingAfter: anotherAnchor, multiplier: multiplier)
        }
    }
    
    public struct YAxis: LayoutAnchor {
        
        public typealias AnchorType = NSLayoutYAxisAnchor
        
        public let target: LayoutTarget
        public let keyPath: KeyPath<LayoutTarget, NSLayoutYAxisAnchor>
        
        @available(iOS 11.0, tvOS 11.0, *)
        @inlinable
        func equal(toSystemSpacingBelow anotherAnchor: BaseLayoutAnchor,
                   multipliedBy multiplier: CGFloat = 1) -> NSLayoutConstraint {
            anchor.constraint(equalToSystemSpacingBelow: anotherAnchor, multiplier: multiplier)
        }
    }
    
    public struct Dimension: LayoutAnchor {
        
        public typealias AnchorType = NSLayoutDimension
        
        public let target: LayoutTarget
        public let keyPath: KeyPath<LayoutTarget, NSLayoutDimension>
        
        public func equal(to constant: CGFloat) -> NSLayoutConstraint {
            anchor.constraint(equalToConstant: constant)
        }
    }
}

extension LayoutRect {
    
    public struct Point {
        var x: XAxis
        var y: YAxis
        
        public func equal<Target>(to another: Target) -> [NSLayoutConstraint] where Target: LayoutTarget {
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
        
        public func equal<Target>(to another: Target) -> [NSLayoutConstraint] where Target: LayoutTarget {
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
        
        public func equal<Target>(to another: Target) -> [NSLayoutConstraint] where Target: LayoutTarget {
            [
                top.equal(to: another),
                left.equal(to: another),
                right.equal(to: another),
                bottom.equal(to: another)
            ]
        }
        
        public func equalToSuperview() -> [NSLayoutConstraint] {
            [
                top.equalToSuperview(),
                left.equalToSuperview(),
                right.equalToSuperview(),
                bottom.equalToSuperview()
            ]
        }
    }
}
