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
                layoutGuide.trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.leading.equal(to: superview.layoutMarginsGuide.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
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
                layoutGuide.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.top.equal(to: superview.layoutMarginsGuide.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
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
                layoutGuide.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor, constant: 8),
                layoutGuide.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor, multiplier: 2)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.width.equal(to: superview.layoutMarginsGuide.heightAnchor, plus: 8)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testPointConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.center.equal(to: superview.layoutMarginsGuide)
            }
            let expectedConstraints = [
                layoutGuide.centerXAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerXAnchor),
                layoutGuide.centerYAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerYAnchor)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testSizeConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = layoutGuide.autoLayout { item in
                item.size.equal(to: superview.layoutMarginsGuide)
            }
            let expectedConstraints = [
                layoutGuide.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor),
                layoutGuide.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor)
            ]
            expectedConstraints.forEach { $0.isActive = true }
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
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
    }
}
