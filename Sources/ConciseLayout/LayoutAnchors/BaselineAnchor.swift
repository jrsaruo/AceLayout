//
//  BaselineAnchor.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/15.
//

import UIKit

public protocol BaselineAnchor: LayoutAnchor where AnchorType == NSLayoutYAxisAnchor,
                                                   BaseLayoutAnchor == NSLayoutYAxisAnchor,
                                                   Target == BaselinesConstrainable {}

extension BaselineAnchor {
    
    @inlinable
    public func equal<Another>(to another: Another,
                               plus offset: CGFloat = 0) -> NSLayoutConstraint where Another: BaselinesConstrainable {
        anchor.constraint(equalTo: another[keyPath: anchorKeyPath], constant: offset)
    }
    
    public func equalToSuperview(plus offset: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = target.superview else {
            preconditionFailure("The layout target must have a superview before making constraints on it.")
        }
        return equal(to: superview, plus: offset)
    }
}
