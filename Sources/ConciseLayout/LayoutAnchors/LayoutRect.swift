//
//  LayoutRect.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/15.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Namespace for layout anchors.
public enum LayoutRect {
    
    public struct XAxis: XAxisAnchor {
        public let target: XAxesConstrainable
        public let anchorKeyPath: KeyPath<XAxesConstrainable, NSLayoutXAxisAnchor>
    }
    
    public struct YAxis: YAxisAnchor {
        public let target: YAxesConstrainable
        public let anchorKeyPath: KeyPath<YAxesConstrainable, NSLayoutYAxisAnchor>
    }
    
    public struct Dimension: LayoutDimension {
        public let target: SizeConstrainable
        public let anchorKeyPath: KeyPath<SizeConstrainable, NSLayoutDimension>
    }
    
    public struct Baseline: BaselineAnchor {
        public let target: BaselinesConstrainable
        public let anchorKeyPath: KeyPath<BaselinesConstrainable, NSLayoutYAxisAnchor>
    }
}

// MARK: - Convenient anchor combinations -

extension LayoutRect {
    
    public struct Point {
        var x: XAxis
        var y: YAxis
        
        // MARK: - Constraints with XYAxesConstrainable
        
        public func equal<Another>(to another: Another,
                                   shiftedBy offset: CGSize = .zero) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            [
                x.equal(to: another, plus: offset.width),
                y.equal(to: another, plus: offset.height)
            ]
        }
        
        public func lessThanOrEqual<Another>(to another: Another,
                                             shiftedBy offset: CGSize = .zero) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            [
                x.lessThanOrEqual(to: another, plus: offset.width),
                y.lessThanOrEqual(to: another, plus: offset.height)
            ]
        }
        
        public func greaterThanOrEqual<Another>(to another: Another,
                                                shiftedBy offset: CGSize = .zero) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            [
                x.greaterThanOrEqual(to: another, plus: offset.width),
                y.greaterThanOrEqual(to: another, plus: offset.height)
            ]
        }
        
        // MARK: - Constraints with superview
        
        public func equalToSuperview(shiftedBy offset: CGSize = .zero) -> [NSLayoutConstraint] {
            [
                x.equalToSuperview(plus: offset.width),
                y.equalToSuperview(plus: offset.height)
            ]
        }
        
        public func lessThanOrEqualToSuperview(shiftedBy offset: CGSize = .zero) -> [NSLayoutConstraint] {
            [
                x.lessThanOrEqualToSuperview(plus: offset.width),
                y.lessThanOrEqualToSuperview(plus: offset.height)
            ]
        }
        
        public func greaterThanOrEqualToSuperview(shiftedBy offset: CGSize = .zero) -> [NSLayoutConstraint] {
            [
                x.greaterThanOrEqualToSuperview(plus: offset.width),
                y.greaterThanOrEqualToSuperview(plus: offset.height)
            ]
        }
    }
    
    public struct Size {
        var width: Dimension
        var height: Dimension
        
        // MARK: - Constraints with SizeConstrainable
        
        public func equal<Another>(to another: Another,
                                   multipliedBy multiplier: CGFloat = 1) -> [NSLayoutConstraint] where Another: SizeConstrainable {
            [
                width.equal(to: another, multipliedBy: multiplier),
                height.equal(to: another, multipliedBy: multiplier)
            ]
        }
        
        public func lessThanOrEqual<Another>(to another: Another,
                                             multipliedBy multiplier: CGFloat = 1) -> [NSLayoutConstraint] where Another: SizeConstrainable {
            [
                width.lessThanOrEqual(to: another, multipliedBy: multiplier),
                height.lessThanOrEqual(to: another, multipliedBy: multiplier)
            ]
        }
        
        public func greaterThanOrEqual<Another>(to another: Another,
                                                multipliedBy multiplier: CGFloat = 1) -> [NSLayoutConstraint] where Another: SizeConstrainable {
            [
                width.greaterThanOrEqual(to: another, multipliedBy: multiplier),
                height.greaterThanOrEqual(to: another, multipliedBy: multiplier)
            ]
        }
        
        // MARK: - Constraints with CGSize
        
        public func equal(to size: CGSize) -> [NSLayoutConstraint] {
            [
                width.equal(to: size.width),
                height.equal(to: size.height)
            ]
        }
        
        public func lessThanOrEqual(to size: CGSize) -> [NSLayoutConstraint] {
            [
                width.lessThanOrEqual(to: size.width),
                height.lessThanOrEqual(to: size.height)
            ]
        }
        
        public func greaterThanOrEqual(to size: CGSize) -> [NSLayoutConstraint] {
            [
                width.greaterThanOrEqual(to: size.width),
                height.greaterThanOrEqual(to: size.height)
            ]
        }
        
        // MARK: - Constraints with sideLength
        
        public func equal(toSquare sideLength: CGFloat) -> [NSLayoutConstraint] {
            [
                width.equal(to: sideLength),
                height.equal(to: sideLength)
            ]
        }
        
        public func lessThanOrEqual(toSquare sideLength: CGFloat) -> [NSLayoutConstraint] {
            [
                width.lessThanOrEqual(to: sideLength),
                height.lessThanOrEqual(to: sideLength)
            ]
        }
        
        public func greaterThanOrEqual(toSquare sideLength: CGFloat) -> [NSLayoutConstraint] {
            [
                width.greaterThanOrEqual(to: sideLength),
                height.greaterThanOrEqual(to: sideLength)
            ]
        }
        
        // MARK: - Constraints with superview
        
        public func equalToSuperview(multipliedBy multiplier: CGFloat = 1) -> [NSLayoutConstraint] {
            [
                width.equalToSuperview(multipliedBy: multiplier),
                height.equalToSuperview(multipliedBy: multiplier)
            ]
        }
        
        public func lessThanOrEqualToSuperview(multipliedBy multiplier: CGFloat = 1) -> [NSLayoutConstraint] {
            [
                width.lessThanOrEqualToSuperview(multipliedBy: multiplier),
                height.lessThanOrEqualToSuperview(multipliedBy: multiplier)
            ]
        }
        
        public func greaterThanOrEqualToSuperview(multipliedBy multiplier: CGFloat = 1) -> [NSLayoutConstraint] {
            [
                width.greaterThanOrEqualToSuperview(multipliedBy: multiplier),
                height.greaterThanOrEqualToSuperview(multipliedBy: multiplier)
            ]
        }
    }
    
    public struct Edges {
        var top: YAxis
        var left: XAxis
        var right: XAxis
        var bottom: YAxis
        
        // MARK: - Constraints with XYAxesConstrainable
        
        public func equal<Another>(to another: Another,
                                   inside insets: EdgeInsets = .zero) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
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
        
        public func insideOrEqual<Another>(to another: Another,
                                           inside insets: EdgeInsets = .zero) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            [
                top.greaterThanOrEqual(to: another, plus: insets.top),
                left.greaterThanOrEqual(to: another, plus: insets.left),
                right.lessThanOrEqual(to: another, plus: -insets.right),
                bottom.lessThanOrEqual(to: another, plus: -insets.bottom)
            ]
        }
        
        @inlinable
        public func insideOrEqual<Another>(to another: Another,
                                           inside inset: CGFloat) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            insideOrEqual(to: another, inside: .init(top: inset, left: inset, bottom: inset, right: inset))
        }
        
        // MARK: - Constraints with superview
        
        public func equalToSuperview(inside insets: EdgeInsets = .zero) -> [NSLayoutConstraint] {
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
        
        public func insideOrEqualToSuperview(inside insets: EdgeInsets = .zero) -> [NSLayoutConstraint] {
            [
                top.greaterThanOrEqualToSuperview(plus: insets.top),
                left.greaterThanOrEqualToSuperview(plus: insets.left),
                right.lessThanOrEqualToSuperview(plus: -insets.right),
                bottom.lessThanOrEqualToSuperview(plus: -insets.bottom)
            ]
        }
        
        @inlinable
        public func insideOrEqualToSuperview(inside inset: CGFloat) -> [NSLayoutConstraint] {
            insideOrEqualToSuperview(inside: .init(top: inset, left: inset, bottom: inset, right: inset))
        }
    }
}
