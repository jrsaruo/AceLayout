//
//  Constrainable.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// A type that provides `superview`.
@MainActor
public protocol SuperviewProviding {
    var superview: AL.View? { get }
}

/// A type that provides layout anchors for creating horizontal layout constraints.
@MainActor
public protocol XAxesConstrainable: SuperviewProviding {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    
    var centerXAnchor: NSLayoutXAxisAnchor { get }
}

/// A type that provides layout anchors for creating vertical layout constraints.
@MainActor
public protocol YAxesConstrainable: SuperviewProviding {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

/// A type that provides layout anchors for creating horizontal and vertical layout constraints.
public typealias XYAxesConstrainable = XAxesConstrainable & YAxesConstrainable

/// A type that provides layout anchors for creating size-based layout constraints.
@MainActor
public protocol SizeConstrainable: SuperviewProviding {
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}

/// A type that provides layout anchors for creating baseline layout constraints.
@MainActor
public protocol BaselinesConstrainable: SuperviewProviding {
    var firstBaselineAnchor: NSLayoutYAxisAnchor { get }
    var lastBaselineAnchor: NSLayoutYAxisAnchor { get }
}

// MARK: - UIView, NSView: Constrainable -

extension AL.View: XYAxesConstrainable, SizeConstrainable, BaselinesConstrainable {}

// MARK: - UILayoutGuide, NSLayoutGuide: Constrainable -

extension AL.LayoutGuide: XYAxesConstrainable, SizeConstrainable {
    public var superview: AL.View? { owningView }
}
