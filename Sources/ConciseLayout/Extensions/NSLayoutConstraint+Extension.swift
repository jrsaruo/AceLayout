//
//  NSLayoutConstraint+Extension.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/05.
//

import UIKit

extension NSLayoutConstraint {
    
    public func priority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}

extension Sequence where Element: NSLayoutConstraint {
    
    public func priority(_ priority: UILayoutPriority) -> Self {
        forEach { $0.priority = priority }
        return self
    }
}
