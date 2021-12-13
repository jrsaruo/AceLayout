//
//  LayoutItem.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/04.
//

import UIKit

public struct LayoutItem {
    let base: LayoutTarget
    
    init(_ target: LayoutTarget) {
        base = target
    }
    
    // MARK: - XAxes
    
    public var leading: LayoutRect.XAxis { .init(target: base, keyPath: \.leadingAnchor) }
    public var trailing: LayoutRect.XAxis { .init(target: base, keyPath: \.trailingAnchor) }
    public var left: LayoutRect.XAxis { .init(target: base, keyPath: \.leftAnchor) }
    public var right: LayoutRect.XAxis { .init(target: base, keyPath: \.rightAnchor) }
    public var centerX: LayoutRect.XAxis { .init(target: base, keyPath: \.centerXAnchor) }
    
    // MARK: - YAxes
    
    public var top: LayoutRect.YAxis { .init(target: base, keyPath: \.topAnchor) }
    public var bottom: LayoutRect.YAxis { .init(target: base, keyPath: \.bottomAnchor) }
    public var centerY: LayoutRect.YAxis { .init(target: base, keyPath: \.centerYAnchor) }
    
    // MARK: - Dimensions
    
    public var width: LayoutRect.Dimension { .init(target: base, keyPath: \.widthAnchor) }
    public var height: LayoutRect.Dimension { .init(target: base, keyPath: \.heightAnchor) }
    
    // MARK: - Conveniences
    
    public var center: LayoutRect.Point { .init(x: centerX, y: centerY) }
    public var size: LayoutRect.Size { .init(width: width, height: height) }
    public var edges: LayoutRect.Edges { .init(top: top, left: left, right: right, bottom: bottom) }
}
