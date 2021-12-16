//
//  UILayoutGuideToUILayoutGuideConstraintTests.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
@testable import ConciseLayout

final class UILayoutGuideToUILayoutGuideConstraintTests: XCTestCase {
    
    private var superview: UIView!
    private var layoutGuide: UILayoutGuide!
    
    override func setUp() {
        super.setUp()
        
        superview = UIView()
        layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
    }
    
    override func tearDown() {
        super.tearDown()
        
        layoutGuide = nil
        superview = nil
    }
    
    func testXAxisConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.equal(to: superview.layoutMarginsGuide)
                item.trailing.equal(to: superview.layoutMarginsGuide, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor),
                layoutGuide.trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor,
                                                      constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.equal(to: superview.layoutMarginsGuide.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor,
                                                     constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testYAxisConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.equal(to: superview.layoutMarginsGuide)
                item.bottom.equal(to: superview.layoutMarginsGuide, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor),
                layoutGuide.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor,
                                                    constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.equal(to: superview.layoutMarginsGuide.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor,
                                                 constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @available(iOS 11.0, tvOS 11.0, *)
    func testXYConstraintsWithSystemSpacing() {
        XCTContext.runActivity(named: "equal(toSystemSpacingAfter:), equal(toSystemSpacingBelow:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.equal(toSystemSpacingBelow: superview.layoutMarginsGuide.topAnchor)
                item.leading.equal(toSystemSpacingAfter: superview.layoutMarginsGuide.leadingAnchor)
                item.trailing.equal(toSystemSpacingAfter: superview.layoutMarginsGuide.trailingAnchor, multipliedBy: -1)
                item.bottom.equal(toSystemSpacingBelow: superview.layoutMarginsGuide.bottomAnchor, multipliedBy: -1)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalToSystemSpacingBelow: superview.layoutMarginsGuide.topAnchor,
                                                 multiplier: 1),
                layoutGuide.leadingAnchor.constraint(equalToSystemSpacingAfter: superview.layoutMarginsGuide.leadingAnchor,
                                                     multiplier: 1),
                layoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: superview.layoutMarginsGuide.trailingAnchor,
                                                      multiplier: -1),
                layoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: superview.layoutMarginsGuide.bottomAnchor,
                                                    multiplier: -1)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testDimensionConstraints() {
        XCTContext.runActivity(named: "equal(to another: SizeConstrainable)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: superview.layoutMarginsGuide)
                item.height.equal(to: superview.layoutMarginsGuide, plus: 8)
                item.height.equal(to: superview.layoutMarginsGuide, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor),
                layoutGuide.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor,
                                                    constant: 8),
                layoutGuide.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor,
                                                    multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: superview.layoutMarginsGuide.heightAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor,
                                                   constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testPointConstraints() {
        XCTContext.runActivity(named: "equal(to another:, shiftedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.center.equal(to: superview.layoutMarginsGuide)
                let offset = CGSize(width: 10, height: 20)
                item.center.equal(to: superview.layoutMarginsGuide, shiftedBy: offset)
            }
            let expectedConstraints = [
                layoutGuide.centerXAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerXAnchor),
                layoutGuide.centerYAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerYAnchor),
                layoutGuide.centerXAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerXAnchor,
                                                     constant: 10),
                layoutGuide.centerYAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerYAnchor,
                                                     constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testSizeConstraints() {
        XCTContext.runActivity(named: "equal(to another:, multipliedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.equal(to: superview.layoutMarginsGuide)
                item.size.equal(to: superview.layoutMarginsGuide, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor),
                layoutGuide.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor),
                layoutGuide.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor,
                                                   multiplier: 2),
                layoutGuide.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor,
                                                    multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testEdgesConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.edges.equal(to: superview.layoutMarginsGuide)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor),
                layoutGuide.leftAnchor.constraint(equalTo: superview.layoutMarginsGuide.leftAnchor),
                layoutGuide.rightAnchor.constraint(equalTo: superview.layoutMarginsGuide.rightAnchor),
                layoutGuide.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
}
