//
//  LayoutRect.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/15.
//

import UIKit

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

extension LayoutRect {
    
    public struct Point {
        var x: XAxis
        var y: YAxis
        
        public func equal<Another>(to another: Another) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
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
        
        public func equal<Another>(to another: Another) -> [NSLayoutConstraint] where Another: SizeConstrainable {
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
