//
//  UILayoutGuideGreaterThanOrEqualToUIViewConstraintTests.swift
//
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
import AceLayout

final class UILayoutGuideGreaterThanOrEqualToUIViewConstraintTests: XCTestCase {
    
    private var superview: AL.View!
    private var layoutGuide: AL.LayoutGuide!
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        superview = AL.View()
        layoutGuide = AL.LayoutGuide()
        superview.addLayoutGuide(layoutGuide)
    }
    
    override func tearDown() {
        super.tearDown()
        
        layoutGuide = nil
        superview = nil
    }
    
    @MainActor
    func testXAxisConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.greaterThanOrEqual(to: superview)
                item.trailing.greaterThanOrEqual(to: superview, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor),
                layoutGuide.trailingAnchor.constraint(
                    greaterThanOrEqualTo: superview.trailingAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.greaterThanOrEqual(to: superview.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(
                    greaterThanOrEqualTo: superview.trailingAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqualToSuperview(plus:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.greaterThanOrEqualToSuperview(plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(
                    greaterThanOrEqualTo: superview.leadingAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testYAxisConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.greaterThanOrEqual(to: superview)
                item.bottom.greaterThanOrEqual(to: superview, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor),
                layoutGuide.bottomAnchor.constraint(
                    greaterThanOrEqualTo: superview.bottomAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.greaterThanOrEqual(to: superview.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(
                    greaterThanOrEqualTo: superview.bottomAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqualToSuperview(plus:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.greaterThanOrEqualToSuperview(plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(
                    greaterThanOrEqualTo: superview.topAnchor,
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
        XCTContext.runActivity(named: "greaterThanOrEqual(toSystemSpacingAfter/Below:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.greaterThanOrEqual(toSystemSpacingBelow: superview.topAnchor)
                item.leading.greaterThanOrEqual(toSystemSpacingAfter: superview.leadingAnchor)
                item.trailing.greaterThanOrEqual(
                    toSystemSpacingAfter: superview.trailingAnchor,
                    multipliedBy: -1
                )
                item.bottom.greaterThanOrEqual(
                    toSystemSpacingBelow: superview.bottomAnchor,
                    multipliedBy: -1
                )
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(
                    greaterThanOrEqualToSystemSpacingBelow: superview.topAnchor,
                    multiplier: 1
                ),
                layoutGuide.leadingAnchor.constraint(
                    greaterThanOrEqualToSystemSpacingAfter: superview.leadingAnchor,
                    multiplier: 1
                ),
                layoutGuide.trailingAnchor.constraint(
                    greaterThanOrEqualToSystemSpacingAfter: superview.trailingAnchor,
                    multiplier: -1
                ),
                layoutGuide.bottomAnchor.constraint(
                    greaterThanOrEqualToSystemSpacingBelow: superview.bottomAnchor,
                    multiplier: -1
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testDimensionConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another: SizeConstrainable)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.greaterThanOrEqual(to: superview)
                item.height.greaterThanOrEqual(to: superview, plus: 8)
                item.height.greaterThanOrEqual(to: superview, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(greaterThanOrEqualTo: superview.widthAnchor),
                layoutGuide.heightAnchor.constraint(
                    greaterThanOrEqualTo: superview.heightAnchor,
                    constant: 8
                ),
                layoutGuide.heightAnchor.constraint(
                    greaterThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.greaterThanOrEqual(to: superview.heightAnchor, plus: 8)
                item.width.greaterThanOrEqual(to: superview.heightAnchor, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(
                    greaterThanOrEqualTo: superview.heightAnchor,
                    constant: 8
                ),
                layoutGuide.widthAnchor.constraint(
                    greaterThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to another: Dimension)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.greaterThanOrEqual(to: item.height, plus: 8)
                item.width.greaterThanOrEqual(to: item.height, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(
                    greaterThanOrEqualTo: layoutGuide.heightAnchor,
                    constant: 8
                ),
                layoutGuide.widthAnchor.constraint(
                    greaterThanOrEqualTo: layoutGuide.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to constant:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.greaterThanOrEqual(to: 100)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqualToSuperview()") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.greaterThanOrEqualToSuperview(plus: 8)
                item.height.greaterThanOrEqualToSuperview(multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(
                    greaterThanOrEqualTo: superview.widthAnchor,
                    constant: 8
                ),
                layoutGuide.heightAnchor.constraint(
                    greaterThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testPointConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another:, shiftedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.center.greaterThanOrEqual(to: superview)
                let offset = CGSize(width: 10, height: 20)
                item.topLeading.greaterThanOrEqual(to: superview, shiftedBy: offset)
            }
            let expectedConstraints = [
                layoutGuide.centerXAnchor.constraint(greaterThanOrEqualTo: superview.centerXAnchor),
                layoutGuide.centerYAnchor.constraint(greaterThanOrEqualTo: superview.centerYAnchor),
                layoutGuide.leadingAnchor.constraint(
                    greaterThanOrEqualTo: superview.leadingAnchor,
                    constant: 10
                ),
                layoutGuide.topAnchor.constraint(
                    greaterThanOrEqualTo: superview.topAnchor,
                    constant: 20
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqualSuperview(shiftedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.topLeft.greaterThanOrEqualToSuperview()
                let offset = CGSize(width: 10, height: 20)
                item.bottomRight.greaterThanOrEqualToSuperview(shiftedBy: offset)
            }
            let expectedConstraints = [
                layoutGuide.leftAnchor.constraint(greaterThanOrEqualTo: superview.leftAnchor),
                layoutGuide.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor),
                layoutGuide.rightAnchor.constraint(
                    greaterThanOrEqualTo: superview.rightAnchor,
                    constant: 10
                ),
                layoutGuide.bottomAnchor.constraint(
                    greaterThanOrEqualTo: superview.bottomAnchor,
                    constant: 20
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testSizeConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another:, multipliedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.greaterThanOrEqual(to: superview)
                item.size.greaterThanOrEqual(to: superview, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(greaterThanOrEqualTo: superview.widthAnchor),
                layoutGuide.heightAnchor.constraint(greaterThanOrEqualTo: superview.heightAnchor),
                layoutGuide.widthAnchor.constraint(
                    greaterThanOrEqualTo: superview.widthAnchor,
                    multiplier: 2
                ),
                layoutGuide.heightAnchor.constraint(
                    greaterThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to size:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.greaterThanOrEqual(to: CGSize(width: 100, height: 200))
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
                layoutGuide.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(toSquare:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.greaterThanOrEqual(toSquare: 100)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
                layoutGuide.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqualSuperview(multipliedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.greaterThanOrEqualToSuperview()
                item.size.greaterThanOrEqualToSuperview(multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(greaterThanOrEqualTo: superview.widthAnchor),
                layoutGuide.heightAnchor.constraint(greaterThanOrEqualTo: superview.heightAnchor),
                layoutGuide.widthAnchor.constraint(
                    greaterThanOrEqualTo: superview.widthAnchor,
                    multiplier: 2
                ),
                layoutGuide.heightAnchor.constraint(
                    greaterThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
}
