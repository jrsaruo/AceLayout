//
//  LayoutConstraintsBuilder.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/04.
//

import UIKit

@resultBuilder
public struct LayoutConstraintsBuilder {
    
    public static func buildBlock(_ components: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        components
    }
}
