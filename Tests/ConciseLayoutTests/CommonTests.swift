//
//  CommonTests.swift
//  ConciseLayout
//
//  Created by Yusaku Nishi on 2021/12/16.
//

import XCTest
@testable import ConciseLayout

final class CommonTests: XCTestCase {
    
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
            XCTAssert(subview.translatesAutoresizingMaskIntoConstraints)
            subview.autoLayout { item in
                item.width.equal(to: 100)
            }
            XCTAssertFalse(subview.translatesAutoresizingMaskIntoConstraints)
        }
        XCTContext.runActivity(named: "引数activatesによるisActiveの制御") { _ in
            XCTContext.runActivity(named: "デフォルトで全制約のisActiveがtrueになること") { _ in
                let constraints = subview.autoLayout { item in
                    item.size.equal(toSquare: 100)
                }
                XCTAssert(constraints.allSatisfy { $0.isActive })
            }
            XCTContext.runActivity(named: "activates: falseのとき全制約のisActiveがfalseになること") { _ in
                let constraints = subview.autoLayout(activates: false) { item in
                    item.size.equal(toSquare: 100)
                }
                XCTAssert(constraints.allSatisfy { !$0.isActive })
            }
        }
    }
}
