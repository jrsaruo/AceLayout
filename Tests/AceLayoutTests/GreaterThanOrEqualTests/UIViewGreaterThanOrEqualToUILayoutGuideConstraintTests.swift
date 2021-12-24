//
//  UIViewGreaterThanOrEqualToUILayoutGuideConstraintTests.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
import AceLayout

final class UIViewGreaterThanOrEqualToUILayoutGuideConstraintTests: XCTestCase {
    
    private var superview: AL.View!
    private var subview: AL.View!
    
    override func setUp() {
        super.setUp()
        
        superview = AL.View()
        subview = AL.View()
        superview.addSubview(subview)
    }
    
    override func tearDown() {
        super.tearDown()
        
        subview.removeFromSuperview()
        subview = nil
        superview = nil
    }
    
    func testXAxisConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.leading.greaterThanOrEqual(to: layoutMarginsGuide)
                item.trailing.greaterThanOrEqual(to: layoutMarginsGuide, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.leadingAnchor),
                subview.trailingAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.trailingAnchor,
                                                  constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.leading.greaterThanOrEqual(to: layoutMarginsGuide.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.trailingAnchor,
                                                 constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testYAxisConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.top.greaterThanOrEqual(to: layoutMarginsGuide)
                item.bottom.greaterThanOrEqual(to: layoutMarginsGuide, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor),
                subview.bottomAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.bottomAnchor,
                                                constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.top.greaterThanOrEqual(to: layoutMarginsGuide.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.bottomAnchor,
                                             constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @available(iOS 11.0, tvOS 11.0, *)
    func testXYConstraintsWithSystemSpacing() {
        XCTContext.runActivity(named: "greaterThanOrEqual(toSystemSpacingAfter/Below:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.top.greaterThanOrEqual(toSystemSpacingBelow: layoutMarginsGuide.topAnchor)
                item.leading.greaterThanOrEqual(toSystemSpacingAfter: layoutMarginsGuide.leadingAnchor)
                item.trailing.greaterThanOrEqual(toSystemSpacingAfter: layoutMarginsGuide.trailingAnchor,
                                                 multipliedBy: -1)
                item.bottom.greaterThanOrEqual(toSystemSpacingBelow: layoutMarginsGuide.bottomAnchor,
                                               multipliedBy: -1)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: layoutMarginsGuide.topAnchor,
                                             multiplier: 1),
                subview.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: layoutMarginsGuide.leadingAnchor,
                                                 multiplier: 1),
                subview.trailingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: layoutMarginsGuide.trailingAnchor,
                                                  multiplier: -1),
                subview.bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: layoutMarginsGuide.bottomAnchor,
                                                multiplier: -1)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testDimensionConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another: SizeConstrainable)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.width.greaterThanOrEqual(to: layoutMarginsGuide)
                item.height.greaterThanOrEqual(to: layoutMarginsGuide, plus: 8)
                item.height.greaterThanOrEqual(to: layoutMarginsGuide, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.widthAnchor),
                subview.heightAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.heightAnchor,
                                                constant: 8),
                subview.heightAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.heightAnchor,
                                                multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.width.greaterThanOrEqual(to: layoutMarginsGuide.heightAnchor, plus: 8)
                item.width.greaterThanOrEqual(to: layoutMarginsGuide.heightAnchor, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.heightAnchor,
                                               constant: 8),
                subview.widthAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.heightAnchor,
                                               multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testBaselineConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.firstBaseline.greaterThanOrEqual(to: layoutMarginsGuide.topAnchor)
                item.firstBaseline.greaterThanOrEqual(to: layoutMarginsGuide.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor),
                subview.firstBaselineAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.bottomAnchor,
                                                       constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testPointConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another:, shiftedBy:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.center.greaterThanOrEqual(to: layoutMarginsGuide)
                let offset = CGSize(width: 10, height: 20)
                item.center.greaterThanOrEqual(to: layoutMarginsGuide, shiftedBy: offset)
            }
            let expectedConstraints = [
                subview.centerXAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.centerXAnchor),
                subview.centerYAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.centerYAnchor),
                subview.centerXAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.centerXAnchor,
                                                 constant: 10),
                subview.centerYAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.centerYAnchor,
                                                 constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testSizeConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another:, multipliedBy:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.size.greaterThanOrEqual(to: layoutMarginsGuide)
                item.size.greaterThanOrEqual(to: layoutMarginsGuide, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.widthAnchor),
                subview.heightAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.heightAnchor),
                subview.widthAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.widthAnchor,
                                               multiplier: 2),
                subview.heightAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.heightAnchor,
                                                multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
}
