//
//  UIViewEqualToUIViewConstraintTests.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
import AceLayout

final class UIViewEqualToUIViewConstraintTests: XCTestCase {
    
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
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leading.equal(to: superview)
                item.trailing.equal(to: superview, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                subview.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leading.equal(to: superview.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(plus:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leading.equalToSuperview(plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testYAxisConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.equal(to: superview)
                item.bottom.equal(to: superview, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.topAnchor),
                subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.equal(to: superview.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.bottomAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(plus:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.equalToSuperview(plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: 8)
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
        XCTContext.runActivity(
            named: "equal(toSystemSpacingAfter:), equal(toSystemSpacingBelow:)"
        ) { _ in
            let constraints = subview.autoLayout { item in
                item.top.equal(toSystemSpacingBelow: superview.topAnchor)
                item.leading.equal(toSystemSpacingAfter: superview.leadingAnchor)
                item.trailing.equal(toSystemSpacingAfter: superview.trailingAnchor, multipliedBy: -1)
                item.bottom.equal(toSystemSpacingBelow: superview.bottomAnchor, multipliedBy: -1)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(
                    equalToSystemSpacingBelow: superview.topAnchor,
                    multiplier: 1
                ),
                subview.leadingAnchor.constraint(
                    equalToSystemSpacingAfter: superview.leadingAnchor,
                    multiplier: 1
                ),
                subview.trailingAnchor.constraint(
                    equalToSystemSpacingAfter: superview.trailingAnchor,
                    multiplier: -1
                ),
                subview.bottomAnchor.constraint(
                    equalToSystemSpacingBelow: superview.bottomAnchor,
                    multiplier: -1
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testDimensionConstraints() {
        XCTContext.runActivity(named: "equal(to another: SizeConstrainable)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.equal(to: superview)
                item.height.equal(to: superview, plus: 8)
                item.height.equal(to: superview, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.widthAnchor),
                subview.heightAnchor.constraint(equalTo: superview.heightAnchor, constant: 8),
                subview.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.equal(to: superview.heightAnchor, plus: 8)
                item.width.equal(to: superview.heightAnchor, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.heightAnchor, constant: 8),
                subview.widthAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to another: Dimension)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.equal(to: item.height, plus: 8)
                item.width.equal(to: item.height, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: subview.heightAnchor, constant: 8),
                subview.widthAnchor.constraint(equalTo: subview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to constant:)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.equal(to: 100)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalToConstant: 100)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview()") { _ in
            let constraints = subview.autoLayout { item in
                item.width.equalToSuperview(plus: 8)
                item.height.equalToSuperview(multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: 8),
                subview.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testBaselineConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = subview.autoLayout { item in
                item.firstBaseline.equal(to: superview)
                item.lastBaseline.equal(to: superview, plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(equalTo: superview.firstBaselineAnchor),
                subview.lastBaselineAnchor.constraint(
                    equalTo: superview.lastBaselineAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.firstBaseline.equal(to: superview.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(equalTo: superview.bottomAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(plus:)") { _ in
            let constraints = subview.autoLayout { item in
                item.firstBaseline.equalToSuperview(plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(
                    equalTo: superview.firstBaselineAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testPointConstraints() {
        XCTContext.runActivity(named: "equal(to another:, shiftedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.center.equal(to: superview)
                let offset = CGSize(width: 10, height: 20)
                item.topLeading.equal(to: superview, shiftedBy: offset)
            }
            let expectedConstraints = [
                subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
                subview.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 10),
                subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalSuperview(shiftedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.topLeft.equalToSuperview()
                let offset = CGSize(width: 10, height: 20)
                item.bottomRight.equalToSuperview(shiftedBy: offset)
            }
            let expectedConstraints = [
                subview.leftAnchor.constraint(equalTo: superview.leftAnchor),
                subview.topAnchor.constraint(equalTo: superview.topAnchor),
                subview.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: 10),
                subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testSizeConstraints() {
        XCTContext.runActivity(named: "equal(to another:, multipliedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.size.equal(to: superview)
                item.size.equal(to: superview, multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.widthAnchor),
                subview.heightAnchor.constraint(equalTo: superview.heightAnchor),
                subview.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 2),
                subview.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to size:)") { _ in
            let constraints = subview.autoLayout { item in
                item.size.equal(to: CGSize(width: 100, height: 200))
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalToConstant: 100),
                subview.heightAnchor.constraint(equalToConstant: 200)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(toSquare:)") { _ in
            let constraints = subview.autoLayout { item in
                item.size.equal(toSquare: 100)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalToConstant: 100),
                subview.heightAnchor.constraint(equalToConstant: 100)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalSuperview(multipliedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.size.equalToSuperview()
                item.size.equalToSuperview(multipliedBy: 2)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.widthAnchor),
                subview.heightAnchor.constraint(equalTo: superview.heightAnchor),
                subview.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 2),
                subview.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testHorizontalEdgesConstraints() {
        XCTContext.runActivity(named: "equal(to:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leadingTrailing.equal(to: superview)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                subview.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to:, insetBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leftRight.equal(to: superview, insetBy: 8)
            }
            let expectedConstraints = [
                subview.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 8),
                subview.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqual(to:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leadingTrailing.insideOrEqual(to: superview)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor),
                subview.trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqual(to:, insetBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leftRight.insideOrEqual(to: superview, insetBy: 8)
            }
            let expectedConstraints = [
                subview.leftAnchor.constraint(
                    greaterThanOrEqualTo: superview.leftAnchor,
                    constant: 8
                ),
                subview.rightAnchor.constraint(
                    lessThanOrEqualTo: superview.rightAnchor,
                    constant: -8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview()") { _ in
            let constraints = subview.autoLayout { item in
                item.leadingTrailing.equalToSuperview()
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                subview.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(insetBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leftRight.equalToSuperview(insetBy: 8)
            }
            let expectedConstraints = [
                subview.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 8),
                subview.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqualToSuperview()") { _ in
            let constraints = subview.autoLayout { item in
                item.leadingTrailing.insideOrEqualToSuperview()
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor),
                subview.trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqualToSuperview(insetBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leftRight.insideOrEqualToSuperview(insetBy: 8)
            }
            let expectedConstraints = [
                subview.leftAnchor.constraint(
                    greaterThanOrEqualTo: superview.leftAnchor,
                    constant: 8
                ),
                subview.rightAnchor.constraint(
                    lessThanOrEqualTo: superview.rightAnchor,
                    constant: -8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testVerticalEdgesConstraints() {
        XCTContext.runActivity(named: "equal(to:)") { _ in
            let constraints = subview.autoLayout { item in
                item.topBottom.equal(to: superview)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.topAnchor),
                subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to:, insetBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.topBottom.equal(to: superview, insetBy: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: 8),
                subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqual(to:)") { _ in
            let constraints = subview.autoLayout { item in
                item.topBottom.insideOrEqual(to: superview)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor),
                subview.bottomAnchor.constraint(lessThanOrEqualTo: superview.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqual(to:, insetBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.topBottom.insideOrEqual(to: superview, insetBy: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(
                    greaterThanOrEqualTo: superview.topAnchor,
                    constant: 8
                ),
                subview.bottomAnchor.constraint(
                    lessThanOrEqualTo: superview.bottomAnchor,
                    constant: -8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview()") { _ in
            let constraints = subview.autoLayout { item in
                item.topBottom.equalToSuperview()
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.topAnchor),
                subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(insetBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.topBottom.equalToSuperview(insetBy: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: 8),
                subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqualToSuperview()") { _ in
            let constraints = subview.autoLayout { item in
                item.topBottom.insideOrEqualToSuperview()
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor),
                subview.bottomAnchor.constraint(lessThanOrEqualTo: superview.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqualToSuperview(insetBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.topBottom.insideOrEqualToSuperview(insetBy: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(
                    greaterThanOrEqualTo: superview.topAnchor,
                    constant: 8
                ),
                subview.bottomAnchor.constraint(
                    lessThanOrEqualTo: superview.bottomAnchor,
                    constant: -8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testEdgesConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = subview.autoLayout { item in
                item.edges.equal(to: superview)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.topAnchor),
                subview.leftAnchor.constraint(equalTo: superview.leftAnchor),
                subview.rightAnchor.constraint(equalTo: superview.rightAnchor),
                subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to another:, insetBy:)") { _ in
            XCTContext.runActivity(named: "insetBy insets: AL.EdgeInsets") { _ in
                let insets = AL.EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = subview.autoLayout { item in
                    item.edges.equal(to: superview, insetBy: insets)
                }
                let expectedConstraints = [
                    subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10),
                    subview.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 20),
                    subview.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -40),
                    subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -30)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
            XCTContext.runActivity(named: "insetBy inset: CGFloat") { _ in
                let constraints = subview.autoLayout { item in
                    item.edges.equal(to: superview, insetBy: 20)
                }
                let expectedConstraints = [
                    subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: 20),
                    subview.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 20),
                    subview.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -20),
                    subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -20)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
        }
        XCTContext.runActivity(named: "insideOrEqual(to another:, insetBy:)") { _ in
            XCTContext.runActivity(named: "insetBy insets: AL.EdgeInsets") { _ in
                let insets = AL.EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = subview.autoLayout { item in
                    item.edges.insideOrEqual(to: superview, insetBy: insets)
                }
                let expectedConstraints = [
                    subview.topAnchor.constraint(
                        greaterThanOrEqualTo: superview.topAnchor,
                        constant: 10
                    ),
                    subview.leftAnchor.constraint(
                        greaterThanOrEqualTo: superview.leftAnchor,
                        constant: 20
                    ),
                    subview.rightAnchor.constraint(
                        lessThanOrEqualTo: superview.rightAnchor,
                        constant: -40
                    ),
                    subview.bottomAnchor.constraint(
                        lessThanOrEqualTo: superview.bottomAnchor,
                        constant: -30
                    )
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
            XCTContext.runActivity(named: "insetBy inset: CGFloat") { _ in
                let constraints = subview.autoLayout { item in
                    item.edges.insideOrEqual(to: superview, insetBy: 20)
                }
                let expectedConstraints = [
                    subview.topAnchor.constraint(
                        greaterThanOrEqualTo: superview.topAnchor,
                        constant: 20
                    ),
                    subview.leftAnchor.constraint(
                        greaterThanOrEqualTo: superview.leftAnchor,
                        constant: 20
                    ),
                    subview.rightAnchor.constraint(
                        lessThanOrEqualTo: superview.rightAnchor,
                        constant: -20
                    ),
                    subview.bottomAnchor.constraint(
                        lessThanOrEqualTo: superview.bottomAnchor,
                        constant: -20
                    )
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
        }
        XCTContext.runActivity(named: "equalToSuperview()") { _ in
            let constraints = subview.autoLayout { item in
                item.edges.equalToSuperview()
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.topAnchor),
                subview.leftAnchor.constraint(equalTo: superview.leftAnchor),
                subview.rightAnchor.constraint(equalTo: superview.rightAnchor),
                subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(insetBy:)") { _ in
            XCTContext.runActivity(named: "insetBy insets: AL.EdgeInsets") { _ in
                let insets = AL.EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = subview.autoLayout { item in
                    item.edges.equalToSuperview(insetBy: insets)
                }
                let expectedConstraints = [
                    subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10),
                    subview.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 20),
                    subview.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -40),
                    subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -30)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
            XCTContext.runActivity(named: "insetBy inset: CGFloat") { _ in
                let constraints = subview.autoLayout { item in
                    item.edges.equalToSuperview(insetBy: 20)
                }
                let expectedConstraints = [
                    subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: 20),
                    subview.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 20),
                    subview.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -20),
                    subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -20)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
        }
        XCTContext.runActivity(named: "insideOrEqualToSuperview(insetBy:)") { _ in
            XCTContext.runActivity(named: "insetBy insets: AL.EdgeInsets") { _ in
                let insets = AL.EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = subview.autoLayout { item in
                    item.edges.insideOrEqualToSuperview(insetBy: insets)
                }
                let expectedConstraints = [
                    subview.topAnchor.constraint(
                        greaterThanOrEqualTo: superview.topAnchor,
                        constant: 10
                    ),
                    subview.leftAnchor.constraint(
                        greaterThanOrEqualTo: superview.leftAnchor,
                        constant: 20
                    ),
                    subview.rightAnchor.constraint(
                        lessThanOrEqualTo: superview.rightAnchor,
                        constant: -40
                    ),
                    subview.bottomAnchor.constraint(
                        lessThanOrEqualTo: superview.bottomAnchor,
                        constant: -30
                    )
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
            XCTContext.runActivity(named: "insetBy inset: CGFloat") { _ in
                let constraints = subview.autoLayout { item in
                    item.edges.insideOrEqualToSuperview(insetBy: 20)
                }
                let expectedConstraints = [
                    subview.topAnchor.constraint(
                        greaterThanOrEqualTo: superview.topAnchor,
                        constant: 20
                    ),
                    subview.leftAnchor.constraint(
                        greaterThanOrEqualTo: superview.leftAnchor,
                        constant: 20
                    ),
                    subview.rightAnchor.constraint(
                        lessThanOrEqualTo: superview.rightAnchor,
                        constant: -20
                    ),
                    subview.bottomAnchor.constraint(
                        lessThanOrEqualTo: superview.bottomAnchor,
                        constant: -20
                    )
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
        }
    }
}
