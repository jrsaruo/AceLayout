//
//  LayoutConstraintsBuilderTests.swift
//  
//
//  Created by Yusaku Nishi on 2022/01/09.
//

import XCTest
import AceLayout

final class LayoutConstraintsBuilderTests: XCTestCase {
    
    private var view: AL.View!
    private let conditionTrue = true
    
    @MainActor
    override func setUp() {
        super.setUp()
        view = AL.View()
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
    }
    
    @MainActor
    func testVoidExpression() {
        func doNothing() {}
        let constraints = view.autoLayout { item in
            doNothing()
        }
        XCTAssert(constraints.isEmpty)
    }
    
    @MainActor
    func testIfStatement() {
        let constraints = view.autoLayout { item in
            if conditionTrue {
                item.width.equal(to: 100)
            }
            if !conditionTrue {
                item.height.equal(to: 50)
            }
        }
        let expectedConstraints = [
            view.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(expectedConstraints)
        assertEqual(constraints, expectedConstraints)
    }
    
    @MainActor
    func testIfElseStatement() {
        let constraints = view.autoLayout { item in
            if conditionTrue {
                item.width.equal(to: 100)
            } else {
                item.height.equal(to: 100)
            }
            if !conditionTrue {
                item.width.equal(to: 50)
            } else {
                item.height.equal(to: 50)
            }
        }
        let expectedConstraints = [
            view.widthAnchor.constraint(equalToConstant: 100),
            view.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(expectedConstraints)
        assertEqual(constraints, expectedConstraints)
    }
}
