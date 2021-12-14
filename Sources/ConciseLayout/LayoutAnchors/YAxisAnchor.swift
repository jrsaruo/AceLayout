//
//  YAxisAnchor.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/14.
//

import UIKit

public protocol YAxisAnchor: LayoutAnchor where AnchorType == NSLayoutYAxisAnchor,
                                                BaseLayoutAnchor == NSLayoutYAxisAnchor,
                                                Target == YAxesConstrainable {}

extension YAxisAnchor {
    
    @inlinable
    public func equal<Another>(to another: Another,
                               plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: YAxesConstrainable {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    public func equalToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return equal(to: superview, plus: offset)
    }
}
