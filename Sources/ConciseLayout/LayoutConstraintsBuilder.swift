//
//  LayoutConstraintsBuilder.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/04.
//

import UIKit

@resultBuilder
public struct LayoutConstraintsBuilder {
    
    public static func buildExpression(_ expression: NSLayoutConstraint) -> [NSLayoutConstraint] {
        [expression]
    }
    
    public static func buildExpression(_ expression: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        expression
    }
    
    public static func buildBlock(_ components: [NSLayoutConstraint]...) -> [NSLayoutConstraint] {
        components.flatMap { $0 }
    }
    
    public static func buildOptional(_ component: [NSLayoutConstraint]?) -> [NSLayoutConstraint] {
        component ?? []
    }
    
    public static func buildEither(first component: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        component
    }
    
    public static func buildEither(second component: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        component
    }
}
