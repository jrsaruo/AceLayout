//
//  UIViewLessThanOrEqualToUIViewConstraintTests.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
import AceLayout

final class UIViewLessThanOrEqualToUIViewConstraintTests: XCTestCase {
    
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
            let constraints = subview.autoLayout { item in
                item.leading.lessThanOrEqual(to: superview)
                item.trailing.lessThanOrEqual(to: superview, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(lessThanOrEqualTo: superview.leadingAnchor),
                subview.trailingAnchor.constraint(
                    lessThanOrEqualTo: superview.trailingAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leading.lessThanOrEqual(to: superview.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(
                    lessThanOrEqualTo: superview.trailingAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqualToSuperview(plus:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leading.lessThanOrEqualToSuperview(plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(
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
            let constraints = subview.autoLayout { item in
                item.top.lessThanOrEqual(to: superview)
                item.bottom.lessThanOrEqual(to: superview, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(lessThanOrEqualTo: superview.topAnchor),
                subview.bottomAnchor.constraint(
                    lessThanOrEqualTo: superview.bottomAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.lessThanOrEqual(to: superview.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(lessThanOrEqualTo: superview.bottomAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqualToSuperview(plus:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.lessThanOrEqualToSuperview(plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(lessThanOrEqualTo: superview.topAnchor, constant: 8)
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
            let constraints = subview.autoLayout { item in
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
                subview.topAnchor.constraint(
                    lessThanOrEqualToSystemSpacingBelow: superview.topAnchor,
                    multiplier: 1
                ),
                subview.leadingAnchor.constraint(
                    lessThanOrEqualToSystemSpacingAfter: superview.leadingAnchor,
                    multiplier: 1
                ),
                subview.trailingAnchor.constraint(
                    lessThanOrEqualToSystemSpacingAfter: superview.trailingAnchor,
                    multiplier: -1
                ),
                subview.bottomAnchor.constraint(
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
            let constraints = subview.autoLayout { item in
                item.width.lessThanOrEqual(to: superview)
                item.height.lessThanOrEqual(to: superview, plus: 8)
                item.height.lessThanOrEqual(to: superview, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(lessThanOrEqualTo: superview.widthAnchor),
                subview.heightAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    constant: 8
                ),
                subview.heightAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.lessThanOrEqual(to: superview.heightAnchor, plus: 8)
                item.width.lessThanOrEqual(to: superview.heightAnchor, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    constant: 8
                ),
                subview.widthAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to another: Dimension)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.lessThanOrEqual(to: item.height, plus: 8)
                item.width.lessThanOrEqual(to: item.height, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(
                    lessThanOrEqualTo: subview.heightAnchor,
                    constant: 8
                ),
                subview.widthAnchor.constraint(
                    lessThanOrEqualTo: subview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to constant:)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.lessThanOrEqual(to: 100)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(lessThanOrEqualToConstant: 100)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqualToSuperview()") { _ in
            let constraints = subview.autoLayout { item in
                item.width.lessThanOrEqualToSuperview(plus: 8)
                item.height.lessThanOrEqualToSuperview(multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(
                    lessThanOrEqualTo: superview.widthAnchor,
                    constant: 8
                ),
                subview.heightAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testBaselineConstraints() {
        XCTContext.runActivity(named: "lessThanOrEqual(to another:)") { _ in
            let constraints = subview.autoLayout { item in
                item.firstBaseline.lessThanOrEqual(to: superview)
                item.lastBaseline.lessThanOrEqual(to: superview, plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(
                    lessThanOrEqualTo: superview.firstBaselineAnchor
                ),
                subview.lastBaselineAnchor.constraint(
                    lessThanOrEqualTo: superview.lastBaselineAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.firstBaseline.lessThanOrEqual(to: superview.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(
                    lessThanOrEqualTo: superview.bottomAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqualToSuperview(plus:)") { _ in
            let constraints = subview.autoLayout { item in
                item.firstBaseline.lessThanOrEqualToSuperview(plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(
                    lessThanOrEqualTo: superview.firstBaselineAnchor,
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
            let constraints = subview.autoLayout { item in
                item.center.lessThanOrEqual(to: superview)
                let offset = CGSize(width: 10, height: 20)
                item.topLeading.lessThanOrEqual(to: superview, shiftedBy: offset)
            }
            let expectedConstraints = [
                subview.centerXAnchor.constraint(lessThanOrEqualTo: superview.centerXAnchor),
                subview.centerYAnchor.constraint(lessThanOrEqualTo: superview.centerYAnchor),
                subview.leadingAnchor.constraint(
                    lessThanOrEqualTo: superview.leadingAnchor,
                    constant: 10
                ),
                subview.topAnchor.constraint(lessThanOrEqualTo: superview.topAnchor, constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqualSuperview(shiftedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.topLeft.lessThanOrEqualToSuperview()
                item.bottomRight.lessThanOrEqualToSuperview(shiftedBy: .init(width: 10, height: 20))
            }
            let expectedConstraints = [
                subview.leftAnchor.constraint(lessThanOrEqualTo: superview.leftAnchor),
                subview.topAnchor.constraint(lessThanOrEqualTo: superview.topAnchor),
                subview.rightAnchor.constraint(
                    lessThanOrEqualTo: superview.rightAnchor,
                    constant: 10
                ),
                subview.bottomAnchor.constraint(
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
            let constraints = subview.autoLayout { item in
                item.size.lessThanOrEqual(to: superview)
                item.size.lessThanOrEqual(to: superview, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(lessThanOrEqualTo: superview.widthAnchor),
                subview.heightAnchor.constraint(lessThanOrEqualTo: superview.heightAnchor),
                subview.widthAnchor.constraint(
                    lessThanOrEqualTo: superview.widthAnchor,
                    multiplier: 2
                ),
                subview.heightAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(to size:)") { _ in
            let constraints = subview.autoLayout { item in
                item.size.lessThanOrEqual(to: CGSize(width: 100, height: 200))
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
                subview.heightAnchor.constraint(lessThanOrEqualToConstant: 200)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqual(toSquare:)") { _ in
            let constraints = subview.autoLayout { item in
                item.size.lessThanOrEqual(toSquare: 100)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
                subview.heightAnchor.constraint(lessThanOrEqualToConstant: 100)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "lessThanOrEqualSuperview(multipliedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.size.lessThanOrEqualToSuperview()
                item.size.lessThanOrEqualToSuperview(multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(lessThanOrEqualTo: superview.widthAnchor),
                subview.heightAnchor.constraint(lessThanOrEqualTo: superview.heightAnchor),
                subview.widthAnchor.constraint(
                    lessThanOrEqualTo: superview.widthAnchor,
                    multiplier: 2
                ),
                subview.heightAnchor.constraint(
                    lessThanOrEqualTo: superview.heightAnchor,
                    multiplier: 2
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
}
