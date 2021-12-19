//
//  Shims.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/16.
//

#if canImport(UIKit)

import UIKit

public typealias View = UIView
public typealias LayoutGuide = UILayoutGuide
public typealias LayoutPriority = UILayoutPriority
public typealias EdgeInsets = UIEdgeInsets

#elseif canImport(AppKit)

import AppKit

public typealias View = NSView
public typealias LayoutGuide = NSLayoutGuide
public typealias LayoutPriority = NSLayoutConstraint.Priority
public typealias EdgeInsets = NSEdgeInsets

extension EdgeInsets {
    public static var zero: Self { .init() }
}

#endif
