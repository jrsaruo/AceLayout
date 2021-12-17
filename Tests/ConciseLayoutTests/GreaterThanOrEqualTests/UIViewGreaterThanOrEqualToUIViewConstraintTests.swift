//
//  UIViewGreaterThanOrEqualToUIViewConstraintTests.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
@testable import ConciseLayout

final class UIViewGreaterThanOrEqualToUIViewConstraintTests: XCTestCase {
    
    private var superview: View!
    private var subview: View!
    
    override func setUp() {
        super.setUp()
        
        superview = View()
        subview = View()
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
            let constraints = subview.autoLayout { item in
                item.leading.greaterThanOrEqual(to: superview)
                item.trailing.greaterThanOrEqual(to: superview, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor),
                subview.trailingAnchor.constraint(greaterThanOrEqualTo: superview.trailingAnchor,
                                                  constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leading.greaterThanOrEqual(to: superview.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(greaterThanOrEqualTo: superview.trailingAnchor,
                                                 constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqualToSuperview(plus:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leading.greaterThanOrEqualToSuperview(plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testYAxisConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.greaterThanOrEqual(to: superview)
                item.bottom.greaterThanOrEqual(to: superview, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor),
                subview.bottomAnchor.constraint(greaterThanOrEqualTo: superview.bottomAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.greaterThanOrEqual(to: superview.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(greaterThanOrEqualTo: superview.bottomAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqualToSuperview(plus:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.greaterThanOrEqualToSuperview(plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @available(iOS 11.0, tvOS 11.0, *)
    func testXYConstraintsWithSystemSpacing() {
        XCTContext.runActivity(named: "greaterThanOrEqual(toSystemSpacingAfter/Below:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.greaterThanOrEqual(toSystemSpacingBelow: superview.topAnchor)
                item.leading.greaterThanOrEqual(toSystemSpacingAfter: superview.leadingAnchor)
                item.trailing.greaterThanOrEqual(toSystemSpacingAfter: superview.trailingAnchor,
                                                 multipliedBy: -1)
                item.bottom.greaterThanOrEqual(toSystemSpacingBelow: superview.bottomAnchor,
                                               multipliedBy: -1)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: superview.topAnchor,
                                             multiplier: 1),
                subview.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: superview.leadingAnchor,
                                                 multiplier: 1),
                subview.trailingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: superview.trailingAnchor,
                                                  multiplier: -1),
                subview.bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: superview.bottomAnchor,
                                                multiplier: -1)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testDimensionConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another: SizeConstrainable)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.greaterThanOrEqual(to: superview)
                item.height.greaterThanOrEqual(to: superview, plus: 8)
                item.height.greaterThanOrEqual(to: superview, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(greaterThanOrEqualTo: superview.widthAnchor),
                subview.heightAnchor.constraint(greaterThanOrEqualTo: superview.heightAnchor, constant: 8),
                subview.heightAnchor.constraint(greaterThanOrEqualTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.greaterThanOrEqual(to: superview.heightAnchor, plus: 8)
                item.width.greaterThanOrEqual(to: superview.heightAnchor, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(greaterThanOrEqualTo: superview.heightAnchor, constant: 8),
                subview.widthAnchor.constraint(greaterThanOrEqualTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to another: Dimension)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.greaterThanOrEqual(to: item.height, plus: 8)
                item.width.greaterThanOrEqual(to: item.height, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(greaterThanOrEqualTo: subview.heightAnchor, constant: 8),
                subview.widthAnchor.constraint(greaterThanOrEqualTo: subview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to constant:)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.greaterThanOrEqual(to: 100)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqualToSuperview()") { _ in
            let constraints = subview.autoLayout { item in
                item.width.greaterThanOrEqualToSuperview(plus: 8)
                item.height.greaterThanOrEqualToSuperview(multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(greaterThanOrEqualTo: superview.widthAnchor, constant: 8),
                subview.heightAnchor.constraint(greaterThanOrEqualTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testBaselineConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another:)") { _ in
            let constraints = subview.autoLayout { item in
                item.firstBaseline.greaterThanOrEqual(to: superview)
                item.lastBaseline.greaterThanOrEqual(to: superview, plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(greaterThanOrEqualTo: superview.firstBaselineAnchor),
                subview.lastBaselineAnchor.constraint(greaterThanOrEqualTo: superview.lastBaselineAnchor,
                                                      constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.firstBaseline.greaterThanOrEqual(to: superview.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(greaterThanOrEqualTo: superview.bottomAnchor,
                                                       constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqualToSuperview(plus:)") { _ in
            let constraints = subview.autoLayout { item in
                item.firstBaseline.greaterThanOrEqualToSuperview(plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(greaterThanOrEqualTo: superview.firstBaselineAnchor,
                                                       constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testPointConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another:, shiftedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.center.greaterThanOrEqual(to: superview)
                let offset = CGSize(width: 10, height: 20)
                item.center.greaterThanOrEqual(to: superview, shiftedBy: offset)
            }
            let expectedConstraints = [
                subview.centerXAnchor.constraint(greaterThanOrEqualTo: superview.centerXAnchor),
                subview.centerYAnchor.constraint(greaterThanOrEqualTo: superview.centerYAnchor),
                subview.centerXAnchor.constraint(greaterThanOrEqualTo: superview.centerXAnchor,
                                                 constant: 10),
                subview.centerYAnchor.constraint(greaterThanOrEqualTo: superview.centerYAnchor,
                                                 constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqualSuperview(shiftedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.center.greaterThanOrEqualToSuperview()
                item.center.greaterThanOrEqualToSuperview(shiftedBy: .init(width: 10, height: 20))
            }
            let expectedConstraints = [
                subview.centerXAnchor.constraint(greaterThanOrEqualTo: superview.centerXAnchor),
                subview.centerYAnchor.constraint(greaterThanOrEqualTo: superview.centerYAnchor),
                subview.centerXAnchor.constraint(greaterThanOrEqualTo: superview.centerXAnchor,
                                                 constant: 10),
                subview.centerYAnchor.constraint(greaterThanOrEqualTo: superview.centerYAnchor,
                                                 constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testSizeConstraints() {
        XCTContext.runActivity(named: "greaterThanOrEqual(to another:, multipliedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.size.greaterThanOrEqual(to: superview)
                item.size.greaterThanOrEqual(to: superview, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(greaterThanOrEqualTo: superview.widthAnchor),
                subview.heightAnchor.constraint(greaterThanOrEqualTo: superview.heightAnchor),
                subview.widthAnchor.constraint(greaterThanOrEqualTo: superview.widthAnchor, multiplier: 2),
                subview.heightAnchor.constraint(greaterThanOrEqualTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(to size:)") { _ in
            let constraints = subview.autoLayout { item in
                item.size.greaterThanOrEqual(to: CGSize(width: 100, height: 200))
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
                subview.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqual(toSquare:)") { _ in
            let constraints = subview.autoLayout { item in
                item.size.greaterThanOrEqual(toSquare: 100)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
                subview.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "greaterThanOrEqualSuperview(multipliedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.size.greaterThanOrEqualToSuperview()
                item.size.greaterThanOrEqualToSuperview(multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(greaterThanOrEqualTo: superview.widthAnchor),
                subview.heightAnchor.constraint(greaterThanOrEqualTo: superview.heightAnchor),
                subview.widthAnchor.constraint(greaterThanOrEqualTo: superview.widthAnchor, multiplier: 2),
                subview.heightAnchor.constraint(greaterThanOrEqualTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
}
