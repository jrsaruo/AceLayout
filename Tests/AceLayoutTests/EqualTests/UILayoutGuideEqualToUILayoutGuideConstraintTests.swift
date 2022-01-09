//
//  UILayoutGuideEqualToUILayoutGuideConstraintTests.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
import AceLayout

final class UILayoutGuideEqualToUILayoutGuideConstraintTests: XCTestCase {
    
    private var superview: AL.View!
    private var layoutGuide: AL.LayoutGuide!
    
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
    
    func testXAxisConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = layoutGuide.autoLayout { item in
                item.leading.equal(to: layoutMarginsGuide)
                item.trailing.equal(to: layoutMarginsGuide, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                layoutGuide.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,
                                                      constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = layoutGuide.autoLayout { item in
                item.leading.equal(to: layoutMarginsGuide.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,
                                                     constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testYAxisConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = layoutGuide.autoLayout { item in
                item.top.equal(to: layoutMarginsGuide)
                item.bottom.equal(to: layoutMarginsGuide, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                layoutGuide.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
                                                    constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = layoutGuide.autoLayout { item in
                item.top.equal(to: layoutMarginsGuide.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
                                                 constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @available(iOS 11.0, tvOS 11.0, *)
    func testXYConstraintsWithSystemSpacing() {
        XCTContext.runActivity(named: "equal(toSystemSpacingAfter:), equal(toSystemSpacingBelow:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = layoutGuide.autoLayout { item in
                item.top.equal(toSystemSpacingBelow: layoutMarginsGuide.topAnchor)
                item.leading.equal(toSystemSpacingAfter: layoutMarginsGuide.leadingAnchor)
                item.trailing.equal(toSystemSpacingAfter: layoutMarginsGuide.trailingAnchor,
                                    multipliedBy: -1)
                item.bottom.equal(toSystemSpacingBelow: layoutMarginsGuide.bottomAnchor,
                                  multipliedBy: -1)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalToSystemSpacingBelow: layoutMarginsGuide.topAnchor,
                                                 multiplier: 1),
                layoutGuide.leadingAnchor.constraint(equalToSystemSpacingAfter: layoutMarginsGuide.leadingAnchor,
                                                     multiplier: 1),
                layoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: layoutMarginsGuide.trailingAnchor,
                                                      multiplier: -1),
                layoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: layoutMarginsGuide.bottomAnchor,
                                                    multiplier: -1)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testDimensionConstraints() {
        XCTContext.runActivity(named: "equal(to another: SizeConstrainable)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: layoutMarginsGuide)
                item.height.equal(to: layoutMarginsGuide, plus: 8)
                item.height.equal(to: layoutMarginsGuide, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor),
                layoutGuide.heightAnchor.constraint(equalTo: layoutMarginsGuide.heightAnchor,
                                                    constant: 8),
                layoutGuide.heightAnchor.constraint(equalTo: layoutMarginsGuide.heightAnchor,
                                                    multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: layoutMarginsGuide.heightAnchor, plus: 8)
                item.width.equal(to: layoutMarginsGuide.heightAnchor, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: layoutMarginsGuide.heightAnchor,
                                                   constant: 8),
                layoutGuide.widthAnchor.constraint(equalTo: layoutMarginsGuide.heightAnchor,
                                                   multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testPointConstraints() {
        XCTContext.runActivity(named: "equal(to another:, shiftedBy:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = layoutGuide.autoLayout { item in
                item.center.equal(to: layoutMarginsGuide)
                let offset = CGSize(width: 10, height: 20)
                item.topLeading.equal(to: layoutMarginsGuide, shiftedBy: offset)
            }
            let expectedConstraints = [
                layoutGuide.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
                layoutGuide.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
                layoutGuide.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,
                                                     constant: 10),
                layoutGuide.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor,
                                                 constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testSizeConstraints() {
        XCTContext.runActivity(named: "equal(to another:, multipliedBy:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = layoutGuide.autoLayout { item in
                item.size.equal(to: layoutMarginsGuide)
                item.size.equal(to: layoutMarginsGuide, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor),
                layoutGuide.heightAnchor.constraint(equalTo: layoutMarginsGuide.heightAnchor),
                layoutGuide.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor,
                                                   multiplier: 2),
                layoutGuide.heightAnchor.constraint(equalTo: layoutMarginsGuide.heightAnchor,
                                                    multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testEdgesConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let layoutMarginsGuide = superview.layoutMarginsGuide
            let constraints = layoutGuide.autoLayout { item in
                item.edges.equal(to: layoutMarginsGuide)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                layoutGuide.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
                layoutGuide.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
                layoutGuide.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to another:, insetBy:)") { _ in
            XCTContext.runActivity(named: "insetBy insets: AL.EdgeInsets") { _ in
                let layoutMarginsGuide = superview.layoutMarginsGuide
                let insets = AL.EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.equal(to: layoutMarginsGuide, insetBy: insets)
                }
                let expectedConstraints = [
                    layoutGuide.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor,
                                                     constant: 10),
                    layoutGuide.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor,
                                                      constant: 20),
                    layoutGuide.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor,
                                                       constant: -40),
                    layoutGuide.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
                                                        constant: -30)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
            XCTContext.runActivity(named: "insetBy inset: CGFloat") { _ in
                let layoutMarginsGuide = superview.layoutMarginsGuide
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.equal(to: layoutMarginsGuide, insetBy: 20)
                }
                let expectedConstraints = [
                    layoutGuide.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor,
                                                     constant: 20),
                    layoutGuide.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor,
                                                      constant: 20),
                    layoutGuide.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor,
                                                       constant: -20),
                    layoutGuide.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
                                                        constant: -20)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
        }
        XCTContext.runActivity(named: "insideOrEqual(to another:, insetBy:)") { _ in
            XCTContext.runActivity(named: "insetBy insets: AL.EdgeInsets") { _ in
                let layoutMarginsGuide = superview.layoutMarginsGuide
                let insets = AL.EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.insideOrEqual(to: layoutMarginsGuide, insetBy: insets)
                }
                let expectedConstraints = [
                    layoutGuide.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor,
                                                     constant: 10),
                    layoutGuide.leftAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.leftAnchor,
                                                      constant: 20),
                    layoutGuide.rightAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.rightAnchor,
                                                       constant: -40),
                    layoutGuide.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor,
                                                        constant: -30)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
            XCTContext.runActivity(named: "insetBy inset: CGFloat") { _ in
                let layoutMarginsGuide = superview.layoutMarginsGuide
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.insideOrEqual(to: layoutMarginsGuide, insetBy: 20)
                }
                let expectedConstraints = [
                    layoutGuide.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor,
                                                     constant: 20),
                    layoutGuide.leftAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.leftAnchor,
                                                      constant: 20),
                    layoutGuide.rightAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.rightAnchor,
                                                       constant: -20),
                    layoutGuide.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor,
                                                        constant: -20)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
        }
    }
}
