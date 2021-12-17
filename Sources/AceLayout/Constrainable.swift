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

public protocol SuperviewProviding {
    var superview: View? { get }
}

public protocol XAxesConstrainable: SuperviewProviding {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    
    var centerXAnchor: NSLayoutXAxisAnchor { get }
}

public protocol YAxesConstrainable: SuperviewProviding {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

public typealias XYAxesConstrainable = XAxesConstrainable & YAxesConstrainable

public protocol SizeConstrainable: SuperviewProviding {
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}

public protocol BaselinesConstrainable: SuperviewProviding {
    var firstBaselineAnchor: NSLayoutYAxisAnchor { get }
    var lastBaselineAnchor: NSLayoutYAxisAnchor { get }
}

// MARK: - UIView, NSView: Constrainable -

extension View: XYAxesConstrainable, SizeConstrainable, BaselinesConstrainable {}

// MARK: - UILayoutGuide, NSLayoutGuide: Constrainable -

extension LayoutGuide: XYAxesConstrainable, SizeConstrainable {
    public var superview: View? { owningView }
}
