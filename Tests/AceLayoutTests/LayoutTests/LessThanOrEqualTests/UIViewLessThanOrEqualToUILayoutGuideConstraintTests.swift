//
//  UIViewLessThanOrEqualToUILayoutGuideConstraintTests.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
import AceLayout

final class UIViewLessThanOrEqualToUILayoutGuideConstraintTests: XCTestCase {
    
    private var superview: AL.View!
    private var subview: AL.View!
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        superview = AL.View()
        subview = AL.View()
        superview.addSubview(subview)
    }
    
    @MainActor
    override func tearDown() {
        super.tearDown()
        
        subview.removeFromSuperview()
        subview = nil
        superview = nil
    }
    
    @MainActor
    func testXAxisConstraints() {
        XCTContext.runActivity(named: "lessThanOrEqual(to another:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.leading.lessThanOrEqual(to: layoutMarginsGuide)
                item.trailing.lessThanOrEqual(to: layoutMarginsGuide, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.leadingAnchor
                ),
                subview.trailingAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.leading.lessThanOrEqual(to: layoutMarginsGuide.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testYAxisConstraints() {
        XCTContext.runActivity(named: "lessThanOrEqual(to another:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.top.lessThanOrEqual(to: layoutMarginsGuide)
                item.bottom.lessThanOrEqual(to: layoutMarginsGuide, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.topAnchor),
                subview.bottomAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.top.lessThanOrEqual(to: layoutMarginsGuide.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testXYConstraintsWithSystemSpacing() throws {
        guard #available(iOS 11.0, tvOS 11.0, *) else {
            throw XCTSkip("This test can only run on iOS 11.0+ or tvOS 11.0+")
        }
        XCTContext.runActivity(named: "lessThanOrEqual(toSystemSpacingAfter/Below:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.top.lessThanOrEqual(toSystemSpacingBelow: layoutMarginsGuide.topAnchor)
                item.leading.lessThanOrEqual(toSystemSpacingAfter: layoutMarginsGuide.leadingAnchor)
                item.trailing.lessThanOrEqual(
                    toSystemSpacingAfter: layoutMarginsGuide.trailingAnchor,
                    multipliedBy: -1
                )
                item.bottom.lessThanOrEqual(
                    toSystemSpacingBelow: layoutMarginsGuide.bottomAnchor,
                    multipliedBy: -1
                )
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(
                    lessThanOrEqualToSystemSpacingBelow: layoutMarginsGuide.topAnchor,
                    multiplier: 1
                ),
                subview.leadingAnchor.constraint(
                    lessThanOrEqualToSystemSpacingAfter: layoutMarginsGuide.leadingAnchor,
                    multiplier: 1
                ),
                subview.trailingAnchor.constraint(
                    lessThanOrEqualToSystemSpacingAfter: layoutMarginsGuide.trailingAnchor,
                    multiplier: -1
                ),
                subview.bottomAnchor.constraint(
                    lessThanOrEqualToSystemSpacingBelow: layoutMarginsGuide.bottomAnchor,
                    multiplier: -1
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testDimensionConstraints() {
        XCTContext.runActivity(named: "lessThanOrEqual(to another: SizeConstrainable)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.width.lessThanOrEqual(to: layoutMarginsGuide)
                item.height.lessThanOrEqual(to: layoutMarginsGuide, plus: 8)
                item.height.lessThanOrEqual(to: layoutMarginsGuide, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.widthAnchor),
                subview.heightAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.heightAnchor,
                    constant: 8
                ),
                subview.heightAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.width.lessThanOrEqual(to: layoutMarginsGuide.heightAnchor, plus: 8)
                item.width.lessThanOrEqual(to: layoutMarginsGuide.heightAnchor, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.heightAnchor,
                    constant: 8
                ),
                subview.widthAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testBaselineConstraints() {
        XCTContext.runActivity(named: "lessThanOrEqual(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.firstBaseline.lessThanOrEqual(to: layoutMarginsGuide.topAnchor)
                item.firstBaseline.lessThanOrEqual(to: layoutMarginsGuide.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.topAnchor
                ),
                subview.firstBaselineAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testPointConstraints() {
        XCTContext.runActivity(named: "lessThanOrEqual(to another:, shiftedBy:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.center.lessThanOrEqual(to: layoutMarginsGuide)
                let offset = CGSize(width: 10, height: 20)
                item.topLeading.lessThanOrEqual(to: layoutMarginsGuide, shiftedBy: offset)
            }
            let expectedConstraints = [
                subview.centerXAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.centerXAnchor
                ),
                subview.centerYAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.centerYAnchor
                ),
                subview.leadingAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.leadingAnchor,
                    constant: 10
                ),
                subview.topAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.topAnchor,
                    constant: 20
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testSizeConstraints() {
        XCTContext.runActivity(named: "lessThanOrEqual(to another:, multipliedBy:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.size.lessThanOrEqual(to: layoutMarginsGuide)
                item.size.lessThanOrEqual(to: layoutMarginsGuide, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.widthAnchor),
                subview.heightAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.heightAnchor),
                subview.widthAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.widthAnchor,
                    multiplier: 2
                ),
                subview.heightAnchor.constraint(
                    lessThanOrEqualTo: layoutMarginsGuide.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
}
