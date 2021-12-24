//
//  Shims.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/16.
//

/// A namespace for shims.
public enum AL {}

#if canImport(UIKit)

import UIKit

extension AL {
    public typealias View = UIView
    public typealias LayoutGuide = UILayoutGuide
    public typealias LayoutPriority = UILayoutPriority
    public typealias EdgeInsets = UIEdgeInsets
}

#elseif canImport(AppKit)

import AppKit

extension AL {
    public typealias View = NSView
    public typealias LayoutGuide = NSLayoutGuide
    public typealias LayoutPriority = NSLayoutConstraint.Priority
    public typealias EdgeInsets = NSEdgeInsets
}

extension AL.EdgeInsets {
    public static var zero: Self { .init() }
}

#endif
