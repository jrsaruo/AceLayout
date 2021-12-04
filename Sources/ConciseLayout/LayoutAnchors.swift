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
    
    func equal<Target>(to another: Target) -> NSLayoutConstraint where Target: LayoutTarget
}

extension LayoutAnchor {
    var anchor: BaseLayoutAnchor { target[keyPath: keyPath] }
    
    public func equal<Target>(to another: Target) -> NSLayoutConstraint where Target: LayoutTarget {
        anchor.constraint(equalTo: another[keyPath: keyPath])
    }
}

/// Namespace for layout anchors.
public enum LayoutRect {
    
    public struct XAxis: LayoutAnchor {
        
        public typealias AnchorType = NSLayoutXAxisAnchor
        
        public let target: LayoutTarget
        public let keyPath: KeyPath<LayoutTarget, NSLayoutXAxisAnchor>
    }
    
    public struct YAxis: LayoutAnchor {
        
        public typealias AnchorType = NSLayoutYAxisAnchor
        
        public let target: LayoutTarget
        public let keyPath: KeyPath<LayoutTarget, NSLayoutYAxisAnchor>
    }
    
    public struct Dimension: LayoutAnchor {
        
        public typealias AnchorType = NSLayoutDimension
        
        public let target: LayoutTarget
        public let keyPath: KeyPath<LayoutTarget, NSLayoutDimension>
    }
}
