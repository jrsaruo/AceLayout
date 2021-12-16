//
//  UIViewEqualToUIViewConstraintTests.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
@testable import ConciseLayout

final class UIViewEqualToUIViewConstraintTests: XCTestCase {
    
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
    
    @available(iOS 11.0, tvOS 11.0, *)
    func testXYConstraintsWithSystemSpacing() {
        XCTContext.runActivity(named: "equal(toSystemSpacingAfter:), equal(toSystemSpacingBelow:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.equal(toSystemSpacingBelow: superview.topAnchor)
                item.leading.equal(toSystemSpacingAfter: superview.leadingAnchor)
                item.trailing.equal(toSystemSpacingAfter: superview.trailingAnchor, multipliedBy: -1)
                item.bottom.equal(toSystemSpacingBelow: superview.bottomAnchor, multipliedBy: -1)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalToSystemSpacingBelow: superview.topAnchor,
                                             multiplier: 1),
                subview.leadingAnchor.constraint(equalToSystemSpacingAfter: superview.leadingAnchor,
                                                 multiplier: 1),
                subview.trailingAnchor.constraint(equalToSystemSpacingAfter: superview.trailingAnchor,
                                                  multiplier: -1),
                subview.bottomAnchor.constraint(equalToSystemSpacingBelow: superview.bottomAnchor,
                                                multiplier: -1)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
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
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.heightAnchor, constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to another: Dimension)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.equal(to: item.height, plus: 8)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: subview.heightAnchor, constant: 8)
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
    
    func testBaselineConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = subview.autoLayout { item in
                item.firstBaseline.equal(to: superview)
                item.lastBaseline.equal(to: superview, plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(equalTo: superview.firstBaselineAnchor),
                subview.lastBaselineAnchor.constraint(equalTo: superview.lastBaselineAnchor, constant: 8)
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
                subview.firstBaselineAnchor.constraint(equalTo: superview.firstBaselineAnchor,
                                                       constant: 8)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testPointConstraints() {
        XCTContext.runActivity(named: "equal(to another:, shiftedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.center.equal(to: superview)
                let offset = CGSize(width: 10, height: 20)
                item.center.equal(to: superview, shiftedBy: offset)
            }
            let expectedConstraints = [
                subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
                subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: 10),
                subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalSuperview(shiftedBy:)") { _ in
            let constraints = subview.autoLayout { item in
                item.center.equalToSuperview()
                item.center.equalToSuperview(shiftedBy: .init(width: 10, height: 20))
            }
            let expectedConstraints = [
                subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
                subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: 10),
                subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: 20)
            ]
            NSLayoutConstraint.activate(expectedConstraints)
            assertEqual(constraints, expectedConstraints)
        }
    }
    
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
        XCTContext.runActivity(named: "equalToSuperview(inside:)") { _ in
            XCTContext.runActivity(named: "inside insets: UIEdgeInsets") { _ in
                let insets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                let constraints = subview.autoLayout { item in
                    item.edges.equalToSuperview(inside: insets)
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
            XCTContext.runActivity(named: "inside inset: CGFloat") { _ in
                let constraints = subview.autoLayout { item in
                    item.edges.equalToSuperview(inside: 20)
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
    }
}
