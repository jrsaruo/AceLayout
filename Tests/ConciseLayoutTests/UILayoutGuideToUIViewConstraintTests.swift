//
//  UILayoutGuideToUIViewConstraintTests.swift
//  ConciseLayout
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
@testable import ConciseLayout

final class UILayoutGuideToUIViewConstraintTests: XCTestCase {
    
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
                item.leading.equal(to: superview)
                item.trailing.equal(to: superview, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                layoutGuide.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 8)
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
    
    @available(iOS 11.0, tvOS 11.0, *)
    func testXYConstraintsWithSystemSpacing() {
        XCTContext.runActivity(named: "equal(toSystemSpacingAfter:), equal(toSystemSpacingBelow:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.equal(toSystemSpacingBelow: superview.topAnchor)
                item.leading.equal(toSystemSpacingAfter: superview.leadingAnchor)
                item.trailing.equal(toSystemSpacingAfter: superview.trailingAnchor, multipliedBy: -1)
                item.bottom.equal(toSystemSpacingBelow: superview.bottomAnchor, multipliedBy: -1)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalToSystemSpacingBelow: superview.topAnchor,
                                                 multiplier: 1),
                layoutGuide.leadingAnchor.constraint(equalToSystemSpacingAfter: superview.leadingAnchor,
                                                     multiplier: 1),
                layoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: superview.trailingAnchor,
                                                      multiplier: -1),
                layoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: superview.bottomAnchor,
                                                    multiplier: -1)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
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
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.heightAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to another: Dimension)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: item.height, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: layoutGuide.heightAnchor, constant: 8)
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
    
    func testPointConstraints() {
        XCTContext.runActivity(named: "equal(to another:, shiftedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.center.equal(to: superview)
                let offset = CGSize(width: 10, height: 20)
                item.center.equal(to: superview, shiftedBy: offset)
            }
            let expectedConstraints = [
                layoutGuide.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                layoutGuide.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
                layoutGuide.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: 10),
                layoutGuide.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalSuperview(shiftedBy:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.center.equalToSuperview()
                item.center.equalToSuperview(shiftedBy: .init(width: 10, height: 20))
            }
            let expectedConstraints = [
                layoutGuide.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                layoutGuide.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
                layoutGuide.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: 10),
                layoutGuide.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
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
        XCTContext.runActivity(named: "equalToSuperview(inside:)") { _ in
            XCTContext.runActivity(named: "inside insets: UIEdgeInsets") { _ in
                let insets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.equalToSuperview(inside: insets)
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
            XCTContext.runActivity(named: "inside inset: CGFloat") { _ in
                let constraints = layoutGuide.autoLayout { item in
                    item.edges.equalToSuperview(inside: 20)
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
    }
}
