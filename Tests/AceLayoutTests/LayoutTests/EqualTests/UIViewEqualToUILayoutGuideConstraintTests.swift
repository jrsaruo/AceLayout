//
//  UIViewEqualToUILayoutGuideConstraintTests.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
import AceLayout

final class UIViewEqualToUILayoutGuideConstraintTests: XCTestCase {
    
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
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.leading.equal(to: layoutMarginsGuide)
                item.trailing.equal(to: layoutMarginsGuide, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                subview.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,
                                                  constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.leading.equal(to: layoutMarginsGuide.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,
                                                 constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testYAxisConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.top.equal(to: layoutMarginsGuide)
                item.bottom.equal(to: layoutMarginsGuide, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                subview.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
                                                constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.top.equal(to: layoutMarginsGuide.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
                                             constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testXYConstraintsWithSystemSpacing() throws {
        guard #available(iOS 11.0, tvOS 11.0, *) else {
            throw XCTSkip("This test can only run on iOS 11.0+ or tvOS 11.0+")
        }
        XCTContext.runActivity(named: "equal(toSystemSpacingAfter:), equal(toSystemSpacingBelow:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.top.equal(toSystemSpacingBelow: layoutMarginsGuide.topAnchor)
                item.leading.equal(toSystemSpacingAfter: layoutMarginsGuide.leadingAnchor)
                item.trailing.equal(toSystemSpacingAfter: layoutMarginsGuide.trailingAnchor, multipliedBy: -1)
                item.bottom.equal(toSystemSpacingBelow: layoutMarginsGuide.bottomAnchor, multipliedBy: -1)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalToSystemSpacingBelow: layoutMarginsGuide.topAnchor,
                                             multiplier: 1),
                subview.leadingAnchor.constraint(equalToSystemSpacingAfter: layoutMarginsGuide.leadingAnchor,
                                                 multiplier: 1),
                subview.trailingAnchor.constraint(equalToSystemSpacingAfter: layoutMarginsGuide.trailingAnchor,
                                                  multiplier: -1),
                subview.bottomAnchor.constraint(equalToSystemSpacingBelow: layoutMarginsGuide.bottomAnchor,
                                                multiplier: -1)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testDimensionConstraints() {
        XCTContext.runActivity(named: "equal(to another: SizeConstrainable)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.width.equal(to: layoutMarginsGuide)
                item.height.equal(to: layoutMarginsGuide, plus: 8)
                item.height.equal(to: layoutMarginsGuide, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor),
                subview.heightAnchor.constraint(equalTo: layoutMarginsGuide.heightAnchor,
                                                constant: 8),
                subview.heightAnchor.constraint(equalTo: layoutMarginsGuide.heightAnchor,
                                                multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.width.equal(to: layoutMarginsGuide.heightAnchor, plus: 8)
                item.width.equal(to: layoutMarginsGuide.heightAnchor, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: layoutMarginsGuide.heightAnchor,
                                               constant: 8),
                subview.widthAnchor.constraint(equalTo: layoutMarginsGuide.heightAnchor,
                                               multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testBaselineConstraints() {
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.firstBaseline.equal(to: layoutMarginsGuide.topAnchor)
                item.firstBaseline.equal(to: layoutMarginsGuide.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                subview.firstBaselineAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
                                                       constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testPointConstraints() {
        XCTContext.runActivity(named: "equal(to another:, shiftedBy:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.center.equal(to: layoutMarginsGuide)
                let offset = CGSize(width: 10, height: 20)
                item.topLeading.equal(to: layoutMarginsGuide, shiftedBy: offset)
            }
            let expectedConstraints = [
                subview.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
                subview.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
                subview.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,
                                                 constant: 10),
                subview.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor,
                                             constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testSizeConstraints() {
        XCTContext.runActivity(named: "equal(to another:, multipliedBy:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.size.equal(to: layoutMarginsGuide)
                item.size.equal(to: layoutMarginsGuide, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor),
                subview.heightAnchor.constraint(equalTo: layoutMarginsGuide.heightAnchor),
                subview.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor,
                                               multiplier: 2),
                subview.heightAnchor.constraint(equalTo: layoutMarginsGuide.heightAnchor,
                                                multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testHorizontalEdgesConstraints() {
        XCTContext.runActivity(named: "equal(to:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.leadingTrailing.equal(to: layoutMarginsGuide)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                subview.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to:, insetBy:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.leftRight.equal(to: layoutMarginsGuide, insetBy: 8)
            }
            let expectedConstraints = [
                subview.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 8),
                subview.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqual(to:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.leadingTrailing.insideOrEqual(to: layoutMarginsGuide)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.leadingAnchor),
                subview.trailingAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqual(to:, insetBy:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.leftRight.insideOrEqual(to: layoutMarginsGuide, insetBy: 8)
            }
            let expectedConstraints = [
                subview.leftAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.leftAnchor,
                                              constant: 8),
                subview.rightAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.rightAnchor,
                                               constant: -8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testVerticalEdgesConstraints() {
        XCTContext.runActivity(named: "equal(to:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.topBottom.equal(to: layoutMarginsGuide)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                subview.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to:, insetBy:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.topBottom.equal(to: layoutMarginsGuide, insetBy: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 8),
                subview.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqual(to:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.topBottom.insideOrEqual(to: layoutMarginsGuide)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor),
                subview.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqual(to:, insetBy:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.topBottom.insideOrEqual(to: layoutMarginsGuide, insetBy: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor,
                                             constant: 8),
                subview.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor,
                                                constant: -8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testEdgesConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = subview.autoLayout { item in
                item.edges.equal(to: layoutMarginsGuide)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                subview.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
                subview.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
                subview.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to another:, insetBy:)") { _ in
            XCTContext.runActivity(named: "insetBy insets: AL.EdgeInsets") { _ in
                let layoutMarginsGuide = superview.layoutMarginsGuide
                let insets = AL.EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = subview.autoLayout { item in
                    item.edges.equal(to: layoutMarginsGuide, insetBy: insets)
                }
                let expectedConstraints = [
                    subview.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10),
                    subview.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 20),
                    subview.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -40),
                    subview.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -30)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
            XCTContext.runActivity(named: "insetBy inset: CGFloat") { _ in
                let layoutMarginsGuide = superview.layoutMarginsGuide
                let constraints = subview.autoLayout { item in
                    item.edges.equal(to: layoutMarginsGuide, insetBy: 20)
                }
                let expectedConstraints = [
                    subview.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 20),
                    subview.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 20),
                    subview.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -20),
                    subview.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -20)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
        }
        XCTContext.runActivity(named: "insideOrEqual(to another:, insetBy:)") { _ in
            XCTContext.runActivity(named: "insetBy insets: AL.EdgeInsets") { _ in
                let layoutMarginsGuide = superview.layoutMarginsGuide
                let insets = AL.EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = subview.autoLayout { item in
                    item.edges.insideOrEqual(to: layoutMarginsGuide, insetBy: insets)
                }
                let expectedConstraints = [
                    subview.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor,
                                                 constant: 10),
                    subview.leftAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.leftAnchor,
                                                  constant: 20),
                    subview.rightAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.rightAnchor,
                                                   constant: -40),
                    subview.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor,
                                                    constant: -30)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
            XCTContext.runActivity(named: "insetBy inset: CGFloat") { _ in
                let layoutMarginsGuide = superview.layoutMarginsGuide
                let constraints = subview.autoLayout { item in
                    item.edges.insideOrEqual(to: layoutMarginsGuide, insetBy: 20)
                }
                let expectedConstraints = [
                    subview.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor,
                                                 constant: 20),
                    subview.leftAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.leftAnchor,
                                                  constant: 20),
                    subview.rightAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.rightAnchor,
                                                   constant: -20),
                    subview.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor,
                                                    constant: -20)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
        }
    }
}
