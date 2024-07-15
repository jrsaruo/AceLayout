//
//  UILayoutGuideEqualToUIViewConstraintTests.swift
//
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
import AceLayout

final class UILayoutGuideEqualToUIViewConstraintTests: XCTestCase {
    
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
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.equal(to: superview)
                item.trailing.equal(to: superview, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                layoutGuide.trailingAnchor.constraint(
                    equalTo: superview.trailingAnchor,
                    constant: 8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.equal(to: superview.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(plus:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.equalToSuperview(plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testYAxisConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.equal(to: superview)
                item.bottom.equal(to: superview, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor),
                layoutGuide.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.equal(to: superview.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.bottomAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(plus:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.equalToSuperview(plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor, constant: 8)
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
            let constraints = layoutGuide.autoLayout { item in
                item.top.equal(toSystemSpacingBelow: superview.topAnchor)
                item.leading.equal(toSystemSpacingAfter: superview.leadingAnchor)
                item.trailing.equal(
                    toSystemSpacingAfter: superview.trailingAnchor,
                    multipliedBy: -1
                )
                item.bottom.equal(toSystemSpacingBelow: superview.bottomAnchor, multipliedBy: -1)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(
                    equalToSystemSpacingBelow: superview.topAnchor,
                    multiplier: 1
                ),
                layoutGuide.leadingAnchor.constraint(
                    equalToSystemSpacingAfter: superview.leadingAnchor,
                    multiplier: 1
                ),
                layoutGuide.trailingAnchor.constraint(
                    equalToSystemSpacingAfter: superview.trailingAnchor,
                    multiplier: -1
                ),
                layoutGuide.bottomAnchor.constraint(
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
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: superview)
                item.height.equal(to: superview, plus: 8)
                item.height.equal(to: superview, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.widthAnchor),
                layoutGuide.heightAnchor.constraint(equalTo: superview.heightAnchor, constant: 8),
                layoutGuide.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: superview.heightAnchor, plus: 8)
                item.width.equal(to: superview.heightAnchor, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.heightAnchor, constant: 8),
                layoutGuide.widthAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to another: Dimension)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: item.height, plus: 8)
                item.width.equal(to: item.height, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: layoutGuide.heightAnchor, constant: 8),
                layoutGuide.widthAnchor.constraint(equalTo: layoutGuide.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to constant:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: 100)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalToConstant: 100)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview()") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.equalToSuperview(plus: 8)
                item.height.equalToSuperview(multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: 8),
                layoutGuide.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testPointConstraints() {
        XCTContext.runActivity(named: "equal(to another:, shiftedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.center.equal(to: superview)
                let offset = CGSize(width: 10, height: 20)
                item.topLeading.equal(to: superview, shiftedBy: offset)
            }
            let expectedConstraints = [
                layoutGuide.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                layoutGuide.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
                layoutGuide.leadingAnchor.constraint(
                    equalTo: superview.leadingAnchor,
                    constant: 10
                ),
                layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor, constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalSuperview(shiftedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.topLeft.equalToSuperview()
                let offset = CGSize(width: 10, height: 20)
                item.bottomRight.equalToSuperview(shiftedBy: offset)
            }
            let expectedConstraints = [
                layoutGuide.leftAnchor.constraint(equalTo: superview.leftAnchor),
                layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor),
                layoutGuide.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: 10),
                layoutGuide.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testSizeConstraints() {
        XCTContext.runActivity(named: "equal(to another:, multipliedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.equal(to: superview)
                item.size.equal(to: superview, multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.widthAnchor),
                layoutGuide.heightAnchor.constraint(equalTo: superview.heightAnchor),
                layoutGuide.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 2),
                layoutGuide.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to size:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.equal(to: CGSize(width: 100, height: 200))
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalToConstant: 100),
                layoutGuide.heightAnchor.constraint(equalToConstant: 200)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(toSquare:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.equal(toSquare: 100)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalToConstant: 100),
                layoutGuide.heightAnchor.constraint(equalToConstant: 100)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalSuperview(multipliedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.equalToSuperview()
                item.size.equalToSuperview(multipliedBy: 2)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.widthAnchor),
                layoutGuide.heightAnchor.constraint(equalTo: superview.heightAnchor),
                layoutGuide.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 2),
                layoutGuide.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 2)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    @MainActor
    func testHorizontalEdgesConstraints() {
        XCTContext.runActivity(named: "equal(to:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leadingTrailing.equal(to: superview)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                layoutGuide.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to:, insetBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leftRight.equal(to: superview, insetBy: 8)
            }
            let expectedConstraints = [
                layoutGuide.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 8),
                layoutGuide.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqual(to:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leadingTrailing.insideOrEqual(to: superview)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor),
                layoutGuide.trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqual(to:, insetBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leftRight.insideOrEqual(to: superview, insetBy: 8)
            }
            let expectedConstraints = [
                layoutGuide.leftAnchor.constraint(
                    greaterThanOrEqualTo: superview.leftAnchor,
                    constant: 8
                ),
                layoutGuide.rightAnchor.constraint(
                    lessThanOrEqualTo: superview.rightAnchor,
                    constant: -8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview()") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leadingTrailing.equalToSuperview()
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                layoutGuide.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(insetBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leftRight.equalToSuperview(insetBy: 8)
            }
            let expectedConstraints = [
                layoutGuide.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 8),
                layoutGuide.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqualToSuperview()") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leadingTrailing.insideOrEqualToSuperview()
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor),
                layoutGuide.trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqualToSuperview(insetBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leftRight.insideOrEqualToSuperview(insetBy: 8)
            }
            let expectedConstraints = [
                layoutGuide.leftAnchor.constraint(
                    greaterThanOrEqualTo: superview.leftAnchor,
                    constant: 8
                ),
                layoutGuide.rightAnchor.constraint(
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
            let constraints = layoutGuide.autoLayout { item in
                item.topBottom.equal(to: superview)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor),
                layoutGuide.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to:, insetBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.topBottom.equal(to: superview, insetBy: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor, constant: 8),
                layoutGuide.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqual(to:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.topBottom.insideOrEqual(to: superview)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor),
                layoutGuide.bottomAnchor.constraint(lessThanOrEqualTo: superview.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqual(to:, insetBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.topBottom.insideOrEqual(to: superview, insetBy: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(
                    greaterThanOrEqualTo: superview.topAnchor,
                    constant: 8
                ),
                layoutGuide.bottomAnchor.constraint(
                    lessThanOrEqualTo: superview.bottomAnchor,
                    constant: -8
                )
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview()") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.topBottom.equalToSuperview()
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor),
                layoutGuide.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(insetBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.topBottom.equalToSuperview(insetBy: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor, constant: 8),
                layoutGuide.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqualToSuperview()") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.topBottom.insideOrEqualToSuperview()
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor),
                layoutGuide.bottomAnchor.constraint(lessThanOrEqualTo: superview.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "insideOrEqualToSuperview(insetBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.topBottom.insideOrEqualToSuperview(insetBy: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(
                    greaterThanOrEqualTo: superview.topAnchor,
                    constant: 8
                ),
                layoutGuide.bottomAnchor.constraint(
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
            let constraints = layoutGuide.autoLayout { item in
                item.edges.equal(to: superview)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor),
                layoutGuide.leftAnchor.constraint(equalTo: superview.leftAnchor),
                layoutGuide.rightAnchor.constraint(equalTo: superview.rightAnchor),
                layoutGuide.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to another:, insetBy:)") { _ in
            XCTContext.runActivity(named: "insetBy insets: AL.EdgeInsets") { _ in
                let insets = AL.EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.equal(to: superview, insetBy: insets)
                }
                let expectedConstraints = [
                    layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10),
                    layoutGuide.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 20),
                    layoutGuide.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -40),
                    layoutGuide.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -30)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
            XCTContext.runActivity(named: "insetBy inset: CGFloat") { _ in
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.equal(to: superview, insetBy: 20)
                }
                let expectedConstraints = [
                    layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor, constant: 20),
                    layoutGuide.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 20),
                    layoutGuide.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -20),
                    layoutGuide.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -20)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
        }
        XCTContext.runActivity(named: "insideOrEqual(to another:, insetBy:)") { _ in
            XCTContext.runActivity(named: "insetBy insets: AL.EdgeInsets") { _ in
                let insets = AL.EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.insideOrEqual(to: superview, insetBy: insets)
                }
                let expectedConstraints = [
                    layoutGuide.topAnchor.constraint(
                        greaterThanOrEqualTo: superview.topAnchor,
                        constant: 10
                    ),
                    layoutGuide.leftAnchor.constraint(
                        greaterThanOrEqualTo: superview.leftAnchor,
                        constant: 20
                    ),
                    layoutGuide.rightAnchor.constraint(
                        lessThanOrEqualTo: superview.rightAnchor,
                        constant: -40
                    ),
                    layoutGuide.bottomAnchor.constraint(
                        lessThanOrEqualTo: superview.bottomAnchor,
                        constant: -30
                    )
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
            XCTContext.runActivity(named: "insetBy inset: CGFloat") { _ in
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.insideOrEqual(to: superview, insetBy: 20)
                }
                let expectedConstraints = [
                    layoutGuide.topAnchor.constraint(
                        greaterThanOrEqualTo: superview.topAnchor,
                        constant: 20
                    ),
                    layoutGuide.leftAnchor.constraint(
                        greaterThanOrEqualTo: superview.leftAnchor,
                        constant: 20
                    ),
                    layoutGuide.rightAnchor.constraint(
                        lessThanOrEqualTo: superview.rightAnchor,
                        constant: -20
                    ),
                    layoutGuide.bottomAnchor.constraint(
                        lessThanOrEqualTo: superview.bottomAnchor,
                        constant: -20
                    )
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
        }
        XCTContext.runActivity(named: "equalToSuperview()") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.edges.equalToSuperview()
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor),
                layoutGuide.leftAnchor.constraint(equalTo: superview.leftAnchor),
                layoutGuide.rightAnchor.constraint(equalTo: superview.rightAnchor),
                layoutGuide.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(insetBy:)") { _ in
            XCTContext.runActivity(named: "insetBy insets: AL.EdgeInsets") { _ in
                let insets = AL.EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.equalToSuperview(insetBy: insets)
                }
                let expectedConstraints = [
                    layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10),
                    layoutGuide.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 20),
                    layoutGuide.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -40),
                    layoutGuide.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -30)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
            XCTContext.runActivity(named: "insetBy inset: CGFloat") { _ in
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.equalToSuperview(insetBy: 20)
                }
                let expectedConstraints = [
                    layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor, constant: 20),
                    layoutGuide.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 20),
                    layoutGuide.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -20),
                    layoutGuide.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -20)
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
        }
        XCTContext.runActivity(named: "insideOrEqualToSuperview(insetBy:)") { _ in
            XCTContext.runActivity(named: "insetBy insets: AL.EdgeInsets") { _ in
                let insets = AL.EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.insideOrEqualToSuperview(insetBy: insets)
                }
                let expectedConstraints = [
                    layoutGuide.topAnchor.constraint(
                        greaterThanOrEqualTo: superview.topAnchor,
                        constant: 10
                    ),
                    layoutGuide.leftAnchor.constraint(
                        greaterThanOrEqualTo: superview.leftAnchor,
                        constant: 20
                    ),
                    layoutGuide.rightAnchor.constraint(
                        lessThanOrEqualTo: superview.rightAnchor,
                        constant: -40
                    ),
                    layoutGuide.bottomAnchor.constraint(
                        lessThanOrEqualTo: superview.bottomAnchor,
                        constant: -30
                    )
                ]
                NSLayoutConstraint.activate(expectedConstraints)
                assertEqual(constraints, expectedConstraints)
            }
            XCTContext.runActivity(named: "insetBy inset: CGFloat") { _ in
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.insideOrEqualToSuperview(insetBy: 20)
                }
                let expectedConstraints = [
                    layoutGuide.topAnchor.constraint(
                        greaterThanOrEqualTo: superview.topAnchor,
                        constant: 20
                    ),
                    layoutGuide.leftAnchor.constraint(
                        greaterThanOrEqualTo: superview.leftAnchor,
                        constant: 20
                    ),
                    layoutGuide.rightAnchor.constraint(
                        lessThanOrEqualTo: superview.rightAnchor,
                        constant: -20
                    ),
                    layoutGuide.bottomAnchor.constraint(
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
