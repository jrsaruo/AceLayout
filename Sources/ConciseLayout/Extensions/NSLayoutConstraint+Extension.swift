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
    
    public func priority(_ priority: LayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}

extension Sequence where Element: NSLayoutConstraint {
    
    public func priority(_ priority: LayoutPriority) -> Self {
        forEach { $0.priority = priority }
        return self
    }
}
