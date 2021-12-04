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
