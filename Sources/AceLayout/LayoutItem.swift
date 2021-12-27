//
//  LayoutItem.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/04.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// A proxy of views or layout guides to create layout constraints.
public struct LayoutItem<Base> {
    let base: Base
    
    /// Creates a new instance with the given layout target.
    /// - Parameter base: A layout target such as `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide`.
    public init(base: Base) {
        self.base = base
    }
}

extension LayoutItem where Base: XAxesConstrainable {
    
    /// A layout anchor representing the leading edge of the target’s frame.
    public var leading: LayoutRect.XAxis { .init(target: base, anchorKeyPath: \.leadingAnchor) }
    
    /// A layout anchor representing the trailing edge of the target’s frame.
    public var trailing: LayoutRect.XAxis { .init(target: base, anchorKeyPath: \.trailingAnchor) }
    
    /// A layout anchor representing the left edge of the target’s frame.
    public var left: LayoutRect.XAxis { .init(target: base, anchorKeyPath: \.leftAnchor) }
    
    /// A layout anchor representing the right edge of the target’s frame.
    public var right: LayoutRect.XAxis { .init(target: base, anchorKeyPath: \.rightAnchor) }
    
    /// A layout anchor representing the horizontal center of the target’s frame.
    public var centerX: LayoutRect.XAxis { .init(target: base, anchorKeyPath: \.centerXAnchor) }
}

extension LayoutItem where Base: YAxesConstrainable {
    
    /// A layout anchor representing the top edge of the target’s frame.
    public var top: LayoutRect.YAxis { .init(target: base, anchorKeyPath: \.topAnchor) }
    
    /// A layout anchor representing the bottom edge of the target’s frame.
    public var bottom: LayoutRect.YAxis { .init(target: base, anchorKeyPath: \.bottomAnchor) }
    
    /// A layout anchor representing the vertical center of the target’s frame.
    public var centerY: LayoutRect.YAxis { .init(target: base, anchorKeyPath: \.centerYAnchor) }
}

extension LayoutItem where Base: XYAxesConstrainable {
    
    /// A convenient anchor that contains layout anchors representing the center of the target’s frame.
    public var center: LayoutRect.Point { .init(x: centerX, y: centerY) }
    
    /// A convenient anchor that contains layout anchors representing the top-leading corner of the target's frame.
    public var topLeading: LayoutRect.Point { .init(x: leading, y: top) }
    
    /// A convenient anchor that contains layout anchors representing the top-trailing corner of the target's frame.
    public var topTrailing: LayoutRect.Point { .init(x: trailing, y: top) }
    
    /// A convenient anchor that contains layout anchors representing the top-left corner of the target's frame.
    public var topLeft: LayoutRect.Point { .init(x: left, y: top) }
    
    /// A convenient anchor that contains layout anchors representing the top-right corner of the target's frame.
    public var topRight: LayoutRect.Point { .init(x: right, y: top) }
    
    /// A convenient anchor that contains layout anchors representing the bottom-leading corner of the target's frame.
    public var bottomLeading: LayoutRect.Point { .init(x: leading, y: bottom) }
    
    /// A convenient anchor that contains layout anchors representing the bottom-trailing corner of the target's frame.
    public var bottomTrailing: LayoutRect.Point { .init(x: trailing, y: bottom) }
    
    /// A convenient anchor that contains layout anchors representing the bottom-left corner of the target's frame.
    public var bottomLeft: LayoutRect.Point { .init(x: left, y: bottom) }
    
    /// A convenient anchor that contains layout anchors representing the bottom-right corner of the target's frame.
    public var bottomRight: LayoutRect.Point { .init(x: right, y: bottom) }
    
    /// A convenient anchor that contains layout anchors representing the top, left, right and bottom edge of the target’s frame.
    public var edges: LayoutRect.Edges { .init(top: top, left: left, right: right, bottom: bottom) }
}

extension LayoutItem where Base: SizeConstrainable {
    
    /// A layout anchor representing the width of the target’s frame.
    public var width: LayoutRect.Dimension { .init(target: base, anchorKeyPath: \.widthAnchor) }
    
    /// A layout anchor representing the height of the target’s frame.
    public var height: LayoutRect.Dimension { .init(target: base, anchorKeyPath: \.heightAnchor) }
    
    /// A convenient anchor that contains layout anchors representing the width and height of the target’s frame.
    public var size: LayoutRect.Size { .init(width: width, height: height) }
}

extension LayoutItem where Base: BaselinesConstrainable {
    
    /// A layout anchor representing the baseline for the topmost line of text in the target.
    public var firstBaseline: LayoutRect.Baseline { .init(target: base,
                                                          anchorKeyPath: \.firstBaselineAnchor) }
    
    /// A layout anchor representing the baseline for the bottommost line of text in the target.
    public var lastBaseline: LayoutRect.Baseline { .init(target: base,
                                                         anchorKeyPath: \.lastBaselineAnchor) }
}
