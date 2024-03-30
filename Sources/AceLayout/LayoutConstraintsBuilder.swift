//
//  LayoutConstraintsBuilder.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/04.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// A custom parameter attribute that constructs layout constraints from closures.
///
/// You can use this as a parameter attribute for layout-constraint-producing closure parameters,
/// allowing those closures to provide multiple layout constraints.
/// For example, the following `buildConstraints` function accepts a closure that produces one or more constraints via the builder.
///
/// ```
/// func buildConstraints(
///     @LayoutConstraintsBuilder builder: () -> [NSLayoutConstraint]
/// ) -> [NSLayoutConstraint]
/// ```
///
/// Clients of this function can use multiple-statement closures to provide several constraints, as shown in the following example:
///
/// ```
/// let constraints = buildConstraints {
///     view.topAnchor.constraint(equalTo: anotherView.topAnchor)
///     view.leadingAnchor.constraint(equalTo: anotherView.leadingAnchor, constant: 16)
///     if view.isHidden {
///         view.heightAnchor.constraint(equalToConstant: 0)
///     }
/// }
/// ```
@resultBuilder
public struct LayoutConstraintsBuilder {
    
    public static func buildExpression(_ expression: NSLayoutConstraint) -> [NSLayoutConstraint] {
        [expression]
    }
    
    public static func buildExpression(_ expression: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        expression
    }
    
    public static func buildExpression(_ expression: ()) -> [NSLayoutConstraint] {
        []
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
