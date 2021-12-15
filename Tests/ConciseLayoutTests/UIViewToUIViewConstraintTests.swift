//
//  UIViewToUIViewConstraintTests.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
@testable import ConciseLayout

final class UIViewToUIViewConstraintTests: XCTestCase {
    
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
    
    func testAutoLayout() {
        XCTContext.runActivity(named: "translatesAutoresizingMaskIntoConstraintsがfalseになること") { _ in
            let view = UIView()
            XCTAssert(view.translatesAutoresizingMaskIntoConstraints)
            view.autoLayout { item in
                item.width.equal(to: 100)
            }
            XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
        }
        XCTContext.runActivity(named: "引数activatesによるisActiveの制御") { _ in
            let view = UIView()
            XCTContext.runActivity(named: "デフォルトで全制約のisActiveがtrueになること") { _ in
                let constraints = view.autoLayout { item in
                    item.width.equal(to: 100)
                }
                XCTAssert(constraints.allSatisfy { $0.isActive })
            }
            XCTContext.runActivity(named: "activates: falseのとき全制約のisActiveがfalseになること") { _ in
                let constraints = view.autoLayout(activates: false) { item in
                    item.width.equal(to: 100)
                }
                XCTAssert(constraints.allSatisfy { !$0.isActive })
            }
        }
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
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leading.equal(to: superview.trailingAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(plus:)") { _ in
            let constraints = subview.autoLayout { item in
                item.leading.equalToSuperview(plus: 8)
            }
            let expectedConstraints = [
                subview.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
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
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.equal(to: superview.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.bottomAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(plus:)") { _ in
            let constraints = subview.autoLayout { item in
                item.top.equalToSuperview(plus: 8)
            }
            let expectedConstraints = [
                subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testDimensionConstraints() {
        XCTContext.runActivity(named: "equal(to another: SizeConstrainable)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.equal(to: superview)
                item.height.equal(to: superview, plus: 8)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.widthAnchor),
                subview.heightAnchor.constraint(equalTo: superview.heightAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.equal(to: superview.heightAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.heightAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to another: Dimension)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.equal(to: item.height, plus: 8)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: subview.heightAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to constant:)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.equal(to: 100)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalToConstant: 100)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(plus:)") { _ in
            let constraints = subview.autoLayout { item in
                item.width.equalToSuperview(plus: 8)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
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
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equal(to anotherAnchor:)") { _ in
            let constraints = subview.autoLayout { item in
                item.firstBaseline.equal(to: superview.bottomAnchor, plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(equalTo: superview.bottomAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalToSuperview(plus:)") { _ in
            let constraints = subview.autoLayout { item in
                item.firstBaseline.equalToSuperview(plus: 8)
            }
            let expectedConstraints = [
                subview.firstBaselineAnchor.constraint(equalTo: superview.firstBaselineAnchor, constant: 8)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testPointConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = subview.autoLayout { item in
                item.center.equal(to: superview)
            }
            let expectedConstraints = [
                subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalSuperview()") { _ in
            let constraints = subview.autoLayout { item in
                item.center.equalToSuperview()
            }
            let expectedConstraints = [
                subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            ]
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
    }
    
    func testSizeConstraints() {
        XCTContext.runActivity(named: "equal(to another:)") { _ in
            let constraints = subview.autoLayout { item in
                item.size.equal(to: superview)
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.widthAnchor),
                subview.heightAnchor.constraint(equalTo: superview.heightAnchor)
            ]
            expectedConstraints.forEach { $0.isActive = true }
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
            expectedConstraints.forEach { $0.isActive = true }
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
            expectedConstraints.forEach { $0.isActive = true }
            assertEqual(constraints, expectedConstraints)
        }
        XCTContext.runActivity(named: "equalSuperview()") { _ in
            let constraints = subview.autoLayout { item in
                item.size.equalToSuperview()
            }
            let expectedConstraints = [
                subview.widthAnchor.constraint(equalTo: superview.widthAnchor),
                subview.heightAnchor.constraint(equalTo: superview.heightAnchor)
            ]
            expectedConstraints.forEach { $0.isActive = true }
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
            expectedConstraints.forEach { $0.isActive = true }
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
            expectedConstraints.forEach { $0.isActive = true }
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
                expectedConstraints.forEach { $0.isActive = true }
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
                expectedConstraints.forEach { $0.isActive = true }
                assertEqual(constraints, expectedConstraints)
            }
        }
    }
}
