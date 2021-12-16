//
//  UIViewEqualToUILayoutGuideConstraintTests.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
@testable import ConciseLayout

final class UIViewEqualToUILayoutGuideConstraintTests: XCTestCase {
    
    private var superview: UIView!
    private var subview: UIView!
    
    override func setUp() {
        super.setUp()
        
        superview = UIView()
        subview = UIView()
        superview.addSubview(subview)
    }
    
    override func tearDown() {
        super.tearDown()
        
        subview.removeFromSuperview()
        subview = nil
        superview = nil
    }
    
    func testXAxisConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leading.equal(to: superview.layoutMarginsGuide)
                item.trailing.equal(to: superview.layoutMarginsGuide, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor),
                subview.trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor,
                                                  constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leading.equal(to: superview.layoutMarginsGuide.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor,
                                                 constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testYAxisConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.equal(to: superview.layoutMarginsGuide)
                item.bottom.equal(to: superview.layoutMarginsGuide, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor),
                subview.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor,
                                                constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.equal(to: superview.layoutMarginsGuide.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor,
                                             constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @available(iOS 11.0, tvOS 11.0, *)
    func testXYConstraintsWithSystemSpacing() {
        XCTContext.runActivity(named: "equal(toSystemSpacingAfter:), equal(toSystemSpacingBelow:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.equal(toSystemSpacingBelow: superview.layoutMarginsGuide.topAnchor)
                item.leading.equal(toSystemSpacingAfter: superview.layoutMarginsGuide.leadingAnchor)
                item.trailing.equal(toSystemSpacingAfter: superview.layoutMarginsGuide.trailingAnchor, multipliedBy: -1)
                item.bottom.equal(toSystemSpacingBelow: superview.layoutMarginsGuide.bottomAnchor, multipliedBy: -1)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalToSystemSpacingBelow: superview.layoutMarginsGuide.topAnchor,
                                             multiplier: 1),
                subview.leadingAnchor.constraint(equalToSystemSpacingAfter: superview.layoutMarginsGuide.leadingAnchor,
                                                 multiplier: 1),
                subview.trailingAnchor.constraint(equalToSystemSpacingAfter: superview.layoutMarginsGuide.trailingAnchor,
                                                  multiplier: -1),
                subview.bottomAnchor.constraint(equalToSystemSpacingBelow: superview.layoutMarginsGuide.bottomAnchor,
                                                multiplier: -1)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testDimensionConstraints() {
        XCTContext.runActivity(named: "equal(to another: SizeConstrainable)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.equal(to: superview.layoutMarginsGuide)
                item.height.equal(to: superview.layoutMarginsGuide, plus: 8)
                item.height.equal(to: superview.layoutMarginsGuide, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor),
                subview.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor,
                                                constant: 8),
                subview.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor,
                                                multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.equal(to: superview.layoutMarginsGuide.heightAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor,
                                               constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testBaselineConstraints() {
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.firstBaseline.equal(to: superview.layoutMarginsGuide.topAnchor)
                item.firstBaseline.equal(to: superview.layoutMarginsGuide.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor),
                subview.firstBaselineAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor,
                                                       constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testPointConstraints() {
        XCTContext.runActivity(named: "equal(to another:, shiftedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.center.equal(to: superview.layoutMarginsGuide)
                let offset = CGSize(width: 10, height: 20)
                item.center.equal(to: superview.layoutMarginsGuide, shiftedBy: offset)
            }
            let expectedConstraints = [
                subview.centerXAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerXAnchor),
                subview.centerYAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerYAnchor),
                subview.centerXAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerXAnchor,
                                                constant: 10),
                subview.centerYAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerYAnchor,
                                                constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testSizeConstraints() {
        XCTContext.runActivity(named: "equal(to another:, multipliedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.size.equal(to: superview.layoutMarginsGuide)
                item.size.equal(to: superview.layoutMarginsGuide, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor),
                subview.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor),
                subview.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor,
                                               multiplier: 2),
                subview.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor,
                                                multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testEdgesConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = subview.autoLayout { item in
                item.edges.equal(to: superview.layoutMarginsGuide)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor),
                subview.leftAnchor.constraint(equalTo: superview.layoutMarginsGuide.leftAnchor),
                subview.rightAnchor.constraint(equalTo: superview.layoutMarginsGuide.rightAnchor),
                subview.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
}
