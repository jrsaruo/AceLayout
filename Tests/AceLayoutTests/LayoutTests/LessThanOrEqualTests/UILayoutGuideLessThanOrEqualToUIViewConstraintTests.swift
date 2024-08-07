//
//  UILayoutGuideLessThanOrEqualToUIViewConstraintTests.swift
//
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
import AceLayout

final class UILayoutGuideLessThanOrEqualToUIViewConstraintTests: XCTestCase {
    
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
        XCTContext.runActivity(named: "lessThanOrEqual(to another:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.lessThanOrEqual(to: superview)
                item.trailing.lessThanOrEqual(to: superview, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(lessThanOrEqualTo: superview.leadingAnchor),
                layoutGuide.trailingAnchor.constraint(
                    lessThanOrEqualTo: superview.trailingAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.lessThanOrEqual(to: superview.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(
                    lessThanOrEqualTo: superview.trailingAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqualToSuperview(plus:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.lessThanOrEqualToSuperview(plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(
                    lessThanOrEqualTo: superview.leadingAnchor,
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
            let constraints = layoutGuide.autoLayout { item in
                item.top.lessThanOrEqual(to: superview)
                item.bottom.lessThanOrEqual(to: superview, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(lessThanOrEqualTo: superview.topAnchor),
                layoutGuide.bottomAnchor.constraint(
                    lessThanOrEqualTo: superview.bottomAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.lessThanOrEqual(to: superview.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(
                    lessThanOrEqualTo: superview.bottomAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqualToSuperview(plus:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.lessThanOrEqualToSuperview(plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(
                    lessThanOrEqualTo: superview.topAnchor,
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
            let constraints = layoutGuide.autoLayout { item in
                item.top.lessThanOrEqual(toSystemSpacingBelow: superview.topAnchor)
                item.leading.lessThanOrEqual(toSystemSpacingAfter: superview.leadingAnchor)
                item.trailing.lessThanOrEqual(
                    toSystemSpacingAfter: superview.trailingAnchor,
                    multipliedBy: -1
                )
                item.bottom.lessThanOrEqual(
                    toSystemSpacingBelow: superview.bottomAnchor,
                    multipliedBy: -1
                )
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(
                    lessThanOrEqualToSystemSpacingBelow: superview.topAnchor,
                    multiplier: 1
                ),
                layoutGuide.leadingAnchor.constraint(
                    lessThanOrEqualToSystemSpacingAfter: superview.leadingAnchor,
                    multiplier: 1
                ),
                layoutGuide.trailingAnchor.constraint(
                    lessThanOrEqualToSystemSpacingAfter: superview.trailingAnchor,
                    multiplier: -1
                ),
                layoutGuide.bottomAnchor.constraint(
                    lessThanOrEqualToSystemSpacingBelow: superview.bottomAnchor,
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
            let constraints = layoutGuide.autoLayout { item in
                item.width.lessThanOrEqual(to: superview)
                item.height.lessThanOrEqual(to: superview, plus: 8)
                item.height.lessThanOrEqual(to: superview, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(lessThanOrEqualTo: superview.widthAnchor),
                layoutGuide.heightAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    constant: 8
                ),
                layoutGuide.heightAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.lessThanOrEqual(to: superview.heightAnchor, plus: 8)
                item.width.lessThanOrEqual(to: superview.heightAnchor, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    constant: 8
                ),
                layoutGuide.widthAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to another: Dimension)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.lessThanOrEqual(to: item.height, plus: 8)
                item.width.lessThanOrEqual(to: item.height, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(
                    lessThanOrEqualTo: layoutGuide.heightAnchor,
                    constant: 8
                ),
                layoutGuide.widthAnchor.constraint(
                    lessThanOrEqualTo: layoutGuide.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to constant:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.lessThanOrEqual(to: 100)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(lessThanOrEqualToConstant: 100)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqualToSuperview()") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.lessThanOrEqualToSuperview(plus: 8)
                item.height.lessThanOrEqualToSuperview(multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(
                    lessThanOrEqualTo: superview.widthAnchor,
                    constant: 8
                ),
                layoutGuide.heightAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testPointConstraints() {
        XCTContext.runActivity(named: "lessThanOrEqual(to another:, shiftedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.center.lessThanOrEqual(to: superview)
                let offset = CGSize(width: 10, height: 20)
                item.topLeading.lessThanOrEqual(to: superview, shiftedBy: offset)
            }
            let expectedConstraints = [
                layoutGuide.centerXAnchor.constraint(lessThanOrEqualTo: superview.centerXAnchor),
                layoutGuide.centerYAnchor.constraint(lessThanOrEqualTo: superview.centerYAnchor),
                layoutGuide.leadingAnchor.constraint(
                    lessThanOrEqualTo: superview.leadingAnchor,
                    constant: 10
                ),
                layoutGuide.topAnchor.constraint(
                    lessThanOrEqualTo: superview.topAnchor,
                    constant: 20
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqualSuperview(shiftedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.topLeft.lessThanOrEqualToSuperview()
                item.bottomRight.lessThanOrEqualToSuperview(shiftedBy: .init(width: 10, height: 20))
            }
            let expectedConstraints = [
                layoutGuide.leftAnchor.constraint(lessThanOrEqualTo: superview.leftAnchor),
                layoutGuide.topAnchor.constraint(lessThanOrEqualTo: superview.topAnchor),
                layoutGuide.rightAnchor.constraint(
                    lessThanOrEqualTo: superview.rightAnchor,
                    constant: 10
                ),
                layoutGuide.bottomAnchor.constraint(
                    lessThanOrEqualTo: superview.bottomAnchor,
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
            let constraints = layoutGuide.autoLayout { item in
                item.size.lessThanOrEqual(to: superview)
                item.size.lessThanOrEqual(to: superview, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(lessThanOrEqualTo: superview.widthAnchor),
                layoutGuide.heightAnchor.constraint(lessThanOrEqualTo: superview.heightAnchor),
                layoutGuide.widthAnchor.constraint(
                    lessThanOrEqualTo: superview.widthAnchor,
                    multiplier: 2
                ),
                layoutGuide.heightAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to size:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.lessThanOrEqual(to: CGSize(width: 100, height: 200))
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
                layoutGuide.heightAnchor.constraint(lessThanOrEqualToConstant: 200)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(toSquare:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.lessThanOrEqual(toSquare: 100)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
                layoutGuide.heightAnchor.constraint(lessThanOrEqualToConstant: 100)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqualSuperview(multipliedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.lessThanOrEqualToSuperview()
                item.size.lessThanOrEqualToSuperview(multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(lessThanOrEqualTo: superview.widthAnchor),
                layoutGuide.heightAnchor.constraint(lessThanOrEqualTo: superview.heightAnchor),
                layoutGuide.widthAnchor.constraint(
                    lessThanOrEqualTo: superview.widthAnchor,
                    multiplier: 2
                ),
                layoutGuide.heightAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
}
