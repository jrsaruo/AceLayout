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
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.equal(to: superview.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(plus:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.equalToSuperview(plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
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
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.equal(to: superview.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.bottomAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(plus:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.equalToSuperview(plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.topAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testDimensionConstraints() {
        XCTContext.runActivity(named: "equal(to another: SizeConstrainable)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: superview)
                item.height.equal(to: superview, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.widthAnchor),
                layoutGuide.heightAnchor.constraint(equalTo: superview.heightAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: superview.heightAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.heightAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to another: Dimension)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: item.height, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: layoutGuide.heightAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to constant:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: 100)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalToConstant: 100)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(plus:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.equalToSuperview(plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testPointConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.center.equal(to: superview)
            }
            let expectedConstraints = [
                layoutGuide.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                layoutGuide.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalSuperview()") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.center.equalToSuperview()
            }
            let expectedConstraints = [
                layoutGuide.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                layoutGuide.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testSizeConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.equal(to: superview)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.widthAnchor),
                layoutGuide.heightAnchor.constraint(equalTo: superview.heightAnchor)
            ]
            expectedConstraints.forEach { $0.isActive = true }
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
            expectedConstraints.forEach { $0.isActive = true }
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
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalSuperview()") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.equalToSuperview()
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.widthAnchor),
                layoutGuide.heightAnchor.constraint(equalTo: superview.heightAnchor)
            ]
            expectedConstraints.forEach { $0.isActive = true }
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
            expectedConstraints.forEach { $0.isActive = true }
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
            expectedConstraints.forEach { $0.isActive = true }
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
                expectedConstraints.forEach { $0.isActive = true }
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
                expectedConstraints.forEach { $0.isActive = true }
                assertEqual(constraints, expectedConstraints)
            }
        }
    }
}
