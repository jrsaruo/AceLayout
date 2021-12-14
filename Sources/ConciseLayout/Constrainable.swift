//
//  Constrainable.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import UIKit

public protocol SuperviewProviding {
    var superview: UIView? { get }
}

public protocol XAxesConstrainable {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    
    var centerXAnchor: NSLayoutXAxisAnchor { get }
}

public protocol YAxesConstrainable {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

public typealias XYAxesConstrainable = XAxesConstrainable & YAxesConstrainable

public protocol DimensionsConstrainable {
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}

public protocol BaselinesConstrainable {
    var firstBaselineAnchor: NSLayoutYAxisAnchor { get }
    var lastBaselineAnchor: NSLayoutYAxisAnchor { get }
}

// MARK: - UIView: Constrainable -

extension UIView: XYAxesConstrainable, DimensionsConstrainable, BaselinesConstrainable {}

// MARK: - UILayoutGuide: Constrainable -

extension UILayoutGuide: XYAxesConstrainable, DimensionsConstrainable {}
