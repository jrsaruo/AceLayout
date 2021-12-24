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

/// A namespace for layout anchors.
public enum LayoutRect {
    
    /// A structure that represents a layout anchor for creating horizontal layout constraints.
    public struct XAxis: XAxisAnchor {
        public let target: XAxesConstrainable
        public let anchorKeyPath: KeyPath<XAxesConstrainable, NSLayoutXAxisAnchor>
    }
    
    /// A structure that represents a layout anchor for creating vertical layout constraints.
    public struct YAxis: YAxisAnchor {
        public let target: YAxesConstrainable
        public let anchorKeyPath: KeyPath<YAxesConstrainable, NSLayoutYAxisAnchor>
    }
    
    /// A structure that represents a layout anchor for creating size-based layout constraints.
    public struct Dimension: LayoutDimension {
        public let target: SizeConstrainable
        public let anchorKeyPath: KeyPath<SizeConstrainable, NSLayoutDimension>
    }
    
    /// A structure that represents a baseline layout anchor for creating vertical layout constraints.
    public struct Baseline: BaselineAnchor {
        public let target: BaselinesConstrainable
        public let anchorKeyPath: KeyPath<BaselinesConstrainable, NSLayoutYAxisAnchor>
    }
}

// MARK: - Convenient anchor combinations -

extension LayoutRect {
    
    /// A structure that contains layout anchors for XY axes.
    public struct Point {
        var x: XAxis
        var y: YAxis
        
        // MARK: - Constraints with XYAxesConstrainable
        
        /// Returns a constraint of the form `self` point == `another` point shifted by `offset`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.center == anotherView.center
        ///     item.center.equal(to: anotherView)
        ///
        ///     // view.centerX == layoutGuide.centerX + 10
        ///     // view.centerY == layoutGuide.centerY + 20
        ///     let offset = CGSize(width: 10, height: 20)
        ///     item.center.equal(to: layoutGuide, shiftedBy: offset)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - another: An instance of the type that conforms to ``XYAxesConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
        ///   - offset: A constant offset for the constraint. The default value is `.zero`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` point == `another` point shifted by `offset`.
        public func equal<Another>(to another: Another,
                                   shiftedBy offset: CGSize = .zero) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            [
                x.equal(to: another, plus: offset.width),
                y.equal(to: another, plus: offset.height)
            ]
        }
        
        /// Returns a constraint of the form `self` point <= `another` point shifted by `offset`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.centerX <= anotherView.centerX
        ///     // view.centerY <= anotherView.centerY
        ///     item.center.lessThanOrEqual(to: anotherView)
        ///
        ///     // view.centerX <= layoutGuide.centerX + 10
        ///     // view.centerY <= layoutGuide.centerY + 20
        ///     let offset = CGSize(width: 10, height: 20)
        ///     item.center.lessThanOrEqual(to: layoutGuide, shiftedBy: offset)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - another: An instance of the type that conforms to ``XYAxesConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
        ///   - offset: A constant offset for the constraint. The default value is `.zero`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` point <= `another` point shifted by `offset`.
        public func lessThanOrEqual<Another>(to another: Another,
                                             shiftedBy offset: CGSize = .zero) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            [
                x.lessThanOrEqual(to: another, plus: offset.width),
                y.lessThanOrEqual(to: another, plus: offset.height)
            ]
        }
        
        /// Returns a constraint of the form `self` point >= `another` point shifted by `offset`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.centerX >= anotherView.centerX
        ///     // view.centerY >= anotherView.centerY
        ///     item.center.greaterThanOrEqual(to: anotherView)
        ///
        ///     // view.centerX >= layoutGuide.centerX + 10
        ///     // view.centerY >= layoutGuide.centerY + 20
        ///     let offset = CGSize(width: 10, height: 20)
        ///     item.center.greaterThanOrEqual(to: layoutGuide, shiftedBy: offset)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - another: An instance of the type that conforms to ``XYAxesConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
        ///   - offset: A constant offset for the constraint. The default value is `.zero`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` point >= `another` point shifted by `offset`.
        public func greaterThanOrEqual<Another>(to another: Another,
                                                shiftedBy offset: CGSize = .zero) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            [
                x.greaterThanOrEqual(to: another, plus: offset.width),
                y.greaterThanOrEqual(to: another, plus: offset.height)
            ]
        }
        
        // MARK: - Constraints with superview
        
        /// Returns a constraint of the form `self` point == `superview` point shifted by `offset`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.center == superview.center
        ///     item.center.equalToSuperview()
        ///
        ///     // view.centerX == superview.centerX + 10
        ///     // view.centerY == superview.centerY + 20
        ///     let offset = CGSize(width: 10, height: 20)
        ///     item.center.equalToSuperview(shiftedBy: offset)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - offset: A constant offset for the constraint. The default value is `.zero`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` point == `superview` point shifted by `offset`.
        public func equalToSuperview(shiftedBy offset: CGSize = .zero) -> [NSLayoutConstraint] {
            [
                x.equalToSuperview(plus: offset.width),
                y.equalToSuperview(plus: offset.height)
            ]
        }
        
        /// Returns a constraint of the form `self` point <= `superview` point shifted by `offset`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.centerX <= superview.centerX
        ///     // view.centerY <= superview.centerY
        ///     item.center.lessThanOrEqualToSuperview()
        ///
        ///     // view.centerX <= superview.centerX + 10
        ///     // view.centerY <= superview.centerY + 20
        ///     let offset = CGSize(width: 10, height: 20)
        ///     item.center.lessThanOrEqualToSuperview(shiftedBy: offset)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - offset: A constant offset for the constraint. The default value is `.zero`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` point <= `superview` point shifted by `offset`.
        public func lessThanOrEqualToSuperview(shiftedBy offset: CGSize = .zero) -> [NSLayoutConstraint] {
            [
                x.lessThanOrEqualToSuperview(plus: offset.width),
                y.lessThanOrEqualToSuperview(plus: offset.height)
            ]
        }
        
        /// Returns a constraint of the form `self` point >= `superview` point shifted by `offset`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.centerX >= superview.centerX
        ///     // view.centerY >= superview.centerY
        ///     item.center.greaterThanOrEqualToSuperview()
        ///
        ///     // view.centerX >= superview.centerX + 10
        ///     // view.centerY >= superview.centerY + 20
        ///     let offset = CGSize(width: 10, height: 20)
        ///     item.center.greaterThanOrEqualToSuperview(shiftedBy: offset)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - offset: A constant offset for the constraint. The default value is `.zero`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` point >= `superview` point shifted by `offset`.
        public func greaterThanOrEqualToSuperview(shiftedBy offset: CGSize = .zero) -> [NSLayoutConstraint] {
            [
                x.greaterThanOrEqualToSuperview(plus: offset.width),
                y.greaterThanOrEqualToSuperview(plus: offset.height)
            ]
        }
    }
    
    /// A structure that contains layout anchors for width and height.
    public struct Size {
        var width: Dimension
        var height: Dimension
        
        // MARK: - Constraints with SizeConstrainable
        
        /// Returns a constraint of the form `self` size == `another` size \* `multiplier`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.size == anotherView.size
        ///     item.size.equal(to: anotherView)
        ///
        ///     // view.width == layoutGuide.width * 1.5
        ///     // view.height == layoutGuide.height * 1.5
        ///     item.size.equal(to: layoutGuide, multipliedBy: 1.5)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - another: An instance of the type that conforms to ``SizeConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
        ///   - multiplier: The multiplier constant for the constraint. The default value is `1`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` size == `another` size \* `multiplier`.
        public func equal<Another>(to another: Another,
                                   multipliedBy multiplier: CGFloat = 1) -> [NSLayoutConstraint] where Another: SizeConstrainable {
            [
                width.equal(to: another, multipliedBy: multiplier),
                height.equal(to: another, multipliedBy: multiplier)
            ]
        }
        
        /// Returns a constraint of the form `self` size <= `another` size \* `multiplier`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.size <= anotherView.size
        ///     item.size.lessThanOrEqual(to: anotherView)
        ///
        ///     // view.width <= layoutGuide.width * 1.5
        ///     // view.height <= layoutGuide.height * 1.5
        ///     item.size.lessThanOrEqual(to: layoutGuide, multipliedBy: 1.5)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - another: An instance of the type that conforms to ``SizeConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
        ///   - multiplier: The multiplier constant for the constraint. The default value is `1`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` size <= `another` size \* `multiplier`.
        public func lessThanOrEqual<Another>(to another: Another,
                                             multipliedBy multiplier: CGFloat = 1) -> [NSLayoutConstraint] where Another: SizeConstrainable {
            [
                width.lessThanOrEqual(to: another, multipliedBy: multiplier),
                height.lessThanOrEqual(to: another, multipliedBy: multiplier)
            ]
        }
        
        /// Returns a constraint of the form `self` size >= `another` size \* `multiplier`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.size >= anotherView.size
        ///     item.size.greaterThanOrEqual(to: anotherView)
        ///
        ///     // view.width >= layoutGuide.width * 1.5
        ///     // view.height >= layoutGuide.height * 1.5
        ///     item.size.greaterThanOrEqual(to: layoutGuide, multipliedBy: 1.5)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - another: An instance of the type that conforms to ``SizeConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
        ///   - multiplier: The multiplier constant for the constraint. The default value is `1`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` size >= `another` size \* `multiplier`.
        public func greaterThanOrEqual<Another>(to another: Another,
                                                multipliedBy multiplier: CGFloat = 1) -> [NSLayoutConstraint] where Another: SizeConstrainable {
            [
                width.greaterThanOrEqual(to: another, multipliedBy: multiplier),
                height.greaterThanOrEqual(to: another, multipliedBy: multiplier)
            ]
        }
        
        // MARK: - Constraints with CGSize
        
        /// Returns a constraint of the form `self` size == `size`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.width == 100
        ///     // view.height == 200
        ///     item.size.equal(to: CGSize(width: 100, height: 200))
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - size: A constant representing the size.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` size == `size`.
        public func equal(to size: CGSize) -> [NSLayoutConstraint] {
            [
                width.equal(to: size.width),
                height.equal(to: size.height)
            ]
        }
        
        /// Returns a constraint of the form `self` size <= `size`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.width <= 100
        ///     // view.height <= 200
        ///     item.size.lessThanOrEqual(to: CGSize(width: 100, height: 200))
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - size: A constant representing the size.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` size <= `size`.
        public func lessThanOrEqual(to size: CGSize) -> [NSLayoutConstraint] {
            [
                width.lessThanOrEqual(to: size.width),
                height.lessThanOrEqual(to: size.height)
            ]
        }
        
        /// Returns a constraint of the form `self` size >= `size`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.width >= 100
        ///     // view.height >= 200
        ///     item.size.greaterThanOrEqual(to: CGSize(width: 100, height: 200))
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - size: A constant representing the size.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` size >= `size`.
        public func greaterThanOrEqual(to size: CGSize) -> [NSLayoutConstraint] {
            [
                width.greaterThanOrEqual(to: size.width),
                height.greaterThanOrEqual(to: size.height)
            ]
        }
        
        // MARK: - Constraints with sideLength
        
        /// Returns a constraint of the form `self` size == square with `sideLength`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.width == 100
        ///     // view.height == 100
        ///     item.size.equal(toSquare: 100)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - sideLength: A constant representing the square side length.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` size == square with `sideLength`.
        public func equal(toSquare sideLength: CGFloat) -> [NSLayoutConstraint] {
            [
                width.equal(to: sideLength),
                height.equal(to: sideLength)
            ]
        }
        
        /// Returns a constraint of the form `self` size <= square with `sideLength`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.width <= 100
        ///     // view.height <= 100
        ///     item.size.lessThanOrEqual(toSquare: 100)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - sideLength: A constant representing the maximum square side length.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` size <= square with `sideLength`.
        public func lessThanOrEqual(toSquare sideLength: CGFloat) -> [NSLayoutConstraint] {
            [
                width.lessThanOrEqual(to: sideLength),
                height.lessThanOrEqual(to: sideLength)
            ]
        }
        
        /// Returns a constraint of the form `self` size >= square with `sideLength`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.width >= 100
        ///     // view.height >= 100
        ///     item.size.greaterThanOrEqual(toSquare: 100)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - sideLength: A constant representing the minimum square side length.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` size >= square with `sideLength`.
        public func greaterThanOrEqual(toSquare sideLength: CGFloat) -> [NSLayoutConstraint] {
            [
                width.greaterThanOrEqual(to: sideLength),
                height.greaterThanOrEqual(to: sideLength)
            ]
        }
        
        // MARK: - Constraints with superview
        
        /// Returns a constraint of the form `self` size == `superview` size \* `multiplier`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.size == superview.size
        ///     item.size.equalToSuperview()
        ///
        ///     // view.width == superview.width * 1.5
        ///     // view.height == superview.height * 1.5
        ///     item.size.equalToSuperview(multipliedBy: 1.5)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - multiplier: The multiplier constant for the constraint. The default value is `1`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` size == `superview` size \* `multiplier`.
        public func equalToSuperview(multipliedBy multiplier: CGFloat = 1) -> [NSLayoutConstraint] {
            [
                width.equalToSuperview(multipliedBy: multiplier),
                height.equalToSuperview(multipliedBy: multiplier)
            ]
        }
        
        /// Returns a constraint of the form `self` size <= `superview` size \* `multiplier`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.size <= superview.size
        ///     item.size.lessThanOrEqualToSuperview()
        ///
        ///     // view.width <= superview.width * 1.5
        ///     // view.height <= superview.height * 1.5
        ///     item.size.lessThanOrEqualToSuperview(multipliedBy: 1.5)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - multiplier: The multiplier constant for the constraint. The default value is `1`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` size <= `superview` size \* `multiplier`.
        public func lessThanOrEqualToSuperview(multipliedBy multiplier: CGFloat = 1) -> [NSLayoutConstraint] {
            [
                width.lessThanOrEqualToSuperview(multipliedBy: multiplier),
                height.lessThanOrEqualToSuperview(multipliedBy: multiplier)
            ]
        }
        
        /// Returns a constraint of the form `self` size >= `superview` size \* `multiplier`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.size >= superview.size
        ///     item.size.greaterThanOrEqualToSuperview()
        ///
        ///     // view.width >= superview.width * 1.5
        ///     // view.height >= superview.height * 1.5
        ///     item.size.greaterThanOrEqualToSuperview(multipliedBy: 1.5)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - multiplier: The multiplier constant for the constraint. The default value is `1`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` size >= `superview` size \* `multiplier`.
        public func greaterThanOrEqualToSuperview(multipliedBy multiplier: CGFloat = 1) -> [NSLayoutConstraint] {
            [
                width.greaterThanOrEqualToSuperview(multipliedBy: multiplier),
                height.greaterThanOrEqualToSuperview(multipliedBy: multiplier)
            ]
        }
    }
    
    /// A structure that contains layout anchors for top, left, right and bottom.
    public struct Edges {
        var top: YAxis
        var left: XAxis
        var right: XAxis
        var bottom: YAxis
        
        // MARK: - Constraints with XYAxesConstrainable
        
        /// Returns a constraint of the form `self` edges == `another` edges adjusted by `insets`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.edges == anotherView.edges
        ///     item.edges.equal(to: anotherView)
        ///
        ///     // view.top == layoutGuide.top + 10
        ///     // view.left == layoutGuide.left + 20
        ///     // view.right == layoutGuide.right - 40
        ///     // view.bottom == layoutGuide.bottom - 30
        ///     let insets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        ///     item.edges.equal(to: layoutGuide, insetBy: insets)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - another: An instance of the type that conforms to ``XYAxesConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
        ///   - insets: A constant edge insets for the constraint. The default value is `.zero`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` edges == `another` edges adjusted by `insets`.
        public func equal<Another>(to another: Another,
                                   insetBy insets: AL.EdgeInsets = .zero) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            [
                top.equal(to: another, plus: insets.top),
                left.equal(to: another, plus: insets.left),
                right.equal(to: another, plus: -insets.right),
                bottom.equal(to: another, plus: -insets.bottom)
            ]
        }
        
        /// Returns a constraint of the form `self` edges == `another` edges adjusted by `inset`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.top == anotherView.top + 16
        ///     // view.left == anotherView.left + 16
        ///     // view.right == anotherView.right - 16
        ///     // view.bottom == anotherView.bottom - 16
        ///     item.edges.equal(to: anotherView, insetBy: 16)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - another: An instance of the type that conforms to ``XYAxesConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
        ///   - inset: A constant edge inset for the constraint.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` edges == `another` edges adjusted by `inset`.
        @inlinable
        public func equal<Another>(to another: Another,
                                   insetBy inset: CGFloat) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            equal(to: another, insetBy: .init(top: inset, left: inset, bottom: inset, right: inset))
        }
        
        /// Returns a constraint that represents `self` edges are inside of `another` edges adjusted by `insets`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.top >= anotherView.top
        ///     // view.left >= anotherView.left
        ///     // view.right <= anotherView.right
        ///     // view.bottom <= anotherView.bottom
        ///     item.edges.insideOrEqual(to: anotherView)
        ///
        ///     // view.top >= layoutGuide.top + 10
        ///     // view.left >= layoutGuide.left + 20
        ///     // view.right <= layoutGuide.right - 40
        ///     // view.bottom <= layoutGuide.bottom - 30
        ///     let insets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        ///     item.edges.insideOrEqual(to: layoutGuide, insetBy: insets)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - another: An instance of the type that conforms to ``XYAxesConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
        ///   - insets: A constant edge insets for the constraint. The default value is `.zero`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` edges are inside of `another` edges adjusted by `insets`.
        public func insideOrEqual<Another>(to another: Another,
                                           insetBy insets: AL.EdgeInsets = .zero) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            [
                top.greaterThanOrEqual(to: another, plus: insets.top),
                left.greaterThanOrEqual(to: another, plus: insets.left),
                right.lessThanOrEqual(to: another, plus: -insets.right),
                bottom.lessThanOrEqual(to: another, plus: -insets.bottom)
            ]
        }
        
        /// Returns a constraint that represents `self` edges are inside of `another` edges adjusted by `inset`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.top >= anotherView.top + 16
        ///     // view.left >= anotherView.left + 16
        ///     // view.right <= anotherView.right - 16
        ///     // view.bottom <= anotherView.bottom - 16
        ///     item.edges.insideOrEqual(to: anotherView, insetBy: 16)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - another: An instance of the type that conforms to ``XYAxesConstrainable`` protocol such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
        ///   - inset: A constant edge inset for the constraint.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` edges are inside of `another` edges adjusted by `inset`.
        @inlinable
        public func insideOrEqual<Another>(to another: Another,
                                           insetBy inset: CGFloat) -> [NSLayoutConstraint] where Another: XYAxesConstrainable {
            insideOrEqual(to: another, insetBy: .init(top: inset, left: inset, bottom: inset, right: inset))
        }
        
        // MARK: - Constraints with superview
        
        /// Returns a constraint of the form `self` edges == `superview` edges adjusted by `insets`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.edges == superview.edges
        ///     item.edges.equalToSuperview()
        ///
        ///     // view.top == superview.top + 10
        ///     // view.left == superview.left + 20
        ///     // view.right == superview.right - 40
        ///     // view.bottom == superview.bottom - 30
        ///     let insets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        ///     item.edges.equalToSuperview(insetBy: insets)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - insets: A constant edge insets for the constraint. The default value is `.zero`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` edges == `superview` edges adjusted by `insets`.
        public func equalToSuperview(insetBy insets: AL.EdgeInsets = .zero) -> [NSLayoutConstraint] {
            [
                top.equalToSuperview(plus: insets.top),
                left.equalToSuperview(plus: insets.left),
                right.equalToSuperview(plus: -insets.right),
                bottom.equalToSuperview(plus: -insets.bottom)
            ]
        }
        
        /// Returns a constraint of the form `self` edges == `superview` edges adjusted by `inset`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.top == superview.top + 16
        ///     // view.left == superview.left + 16
        ///     // view.right == superview.right - 16
        ///     // view.bottom == superview.bottom - 16
        ///     item.edges.equalToSuperview(insetBy: 16)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - inset: A constant edge inset for the constraint.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` edges == `superview` edges adjusted by `inset`.
        @inlinable
        public func equalToSuperview(insetBy inset: CGFloat) -> [NSLayoutConstraint] {
            equalToSuperview(insetBy: .init(top: inset, left: inset, bottom: inset, right: inset))
        }
        
        /// Returns a constraint that represents `self` edges are inside of `another` edges adjusted by `insets`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.top >= superview.top
        ///     // view.left >= superview.left
        ///     // view.right <= superview.right
        ///     // view.bottom <= superview.bottom
        ///     item.edges.insideOrEqualToSuperview()
        ///
        ///     // view.top >= superview.top + 10
        ///     // view.left >= superview.left + 20
        ///     // view.right <= superview.right - 40
        ///     // view.bottom <= superview.bottom - 30
        ///     let insets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        ///     item.edges.insideOrEqualToSuperview(insetBy: insets)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - insets: A constant edge insets for the constraint. The default value is `.zero`.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` edges are inside of `superview` edges adjusted by `insets`.
        public func insideOrEqualToSuperview(insetBy insets: AL.EdgeInsets = .zero) -> [NSLayoutConstraint] {
            [
                top.greaterThanOrEqualToSuperview(plus: insets.top),
                left.greaterThanOrEqualToSuperview(plus: insets.left),
                right.lessThanOrEqualToSuperview(plus: -insets.right),
                bottom.lessThanOrEqualToSuperview(plus: -insets.bottom)
            ]
        }
        
        /// Returns a constraint that represents `self` edges are inside of `superview` edges adjusted by `inset`.
        ///
        /// ```
        /// view.autoLayout { item in
        ///     // view.top >= superview.top + 16
        ///     // view.left >= superview.left + 16
        ///     // view.right <= superview.right - 16
        ///     // view.bottom <= superview.bottom - 16
        ///     item.edges.insideOrEqualToSuperview(insetBy: 16)
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - inset: A constant edge inset for the constraint.
        /// - Returns: An  `NSLayoutConstraint` object that represents `self` edges are inside of `superview` edges adjusted by `inset`.
        @inlinable
        public func insideOrEqualToSuperview(insetBy inset: CGFloat) -> [NSLayoutConstraint] {
            insideOrEqualToSuperview(insetBy: .init(top: inset, left: inset, bottom: inset, right: inset))
        }
    }
}
