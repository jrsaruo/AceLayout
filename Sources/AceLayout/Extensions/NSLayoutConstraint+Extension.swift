//
//  NSLayoutConstraint+Extension.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/05.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension NSLayoutConstraint {
    
    /// Updates the constraint with the specified `priority`.
    /// - Parameter priority: The layout priority.
    /// - Returns: The updated `self` with the specified `priority`.
    @discardableResult
    public func priority(_ priority: AL.LayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}

extension Sequence<NSLayoutConstraint> {
    
    /// Updates each constraint with the specified `priority`.
    /// - Parameter priority: The layout priority.
    /// - Returns: The updated `self` with the specified `priority`.
    @discardableResult
    public func priority(_ priority: AL.LayoutPriority) -> Self {
        forEach { $0.priority = priority }
        return self
    }
}
