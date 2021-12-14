//
//  LayoutItem.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/04.
//

import UIKit

public struct LayoutItem<Base> {
    let base: Base
    
    public init(base: Base) {
        self.base = base
    }
}

extension LayoutItem where Base: XAxesConstrainable {
    public var leading: LayoutRect.XAxis { .init(target: base, anchorKeyPath: \.leadingAnchor) }
    public var trailing: LayoutRect.XAxis { .init(target: base, anchorKeyPath: \.trailingAnchor) }
    public var left: LayoutRect.XAxis { .init(target: base, anchorKeyPath: \.leftAnchor) }
    public var right: LayoutRect.XAxis { .init(target: base, anchorKeyPath: \.rightAnchor) }
    
    public var centerX: LayoutRect.XAxis { .init(target: base, anchorKeyPath: \.centerXAnchor) }
}

extension LayoutItem where Base: YAxesConstrainable {
    public var top: LayoutRect.YAxis { .init(target: base, anchorKeyPath: \.topAnchor) }
    public var bottom: LayoutRect.YAxis { .init(target: base, anchorKeyPath: \.bottomAnchor) }
    
    public var centerY: LayoutRect.YAxis { .init(target: base, anchorKeyPath: \.centerYAnchor) }
}

extension LayoutItem where Base: XYAxesConstrainable {
    public var center: LayoutRect.Point { .init(x: centerX, y: centerY) }
    public var edges: LayoutRect.Edges { .init(top: top, left: left, right: right, bottom: bottom) }
}

extension LayoutItem where Base: DimensionsConstrainable {
    public var width: LayoutRect.Dimension { .init(target: base, anchorKeyPath: \.widthAnchor) }
    public var height: LayoutRect.Dimension { .init(target: base, anchorKeyPath: \.heightAnchor) }
    
    public var size: LayoutRect.Size { .init(width: width, height: height) }
}

extension LayoutItem where Base: BaselinesConstrainable {
    public var firstBaseline: LayoutRect.Baseline { .init(target: base,
                                                          anchorKeyPath: \.firstBaselineAnchor) }
    public var lastBaseline: LayoutRect.Baseline { .init(target: base,
                                                         anchorKeyPath: \.lastBaselineAnchor) }
}
