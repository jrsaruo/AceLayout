//
//  LayoutTargetTests.swift
//  
//
//  Created by Yusaku Nishi on 2022/01/10.
//

import XCTest
import AceLayout

final class LayoutTargetTests: XCTestCase {
    
    func testAutoLayout() {
        XCTContext.runActivity(
            named: "translatesAutoresizingMaskIntoConstraints should become false"
        ) { _ in
            let view = AL.View()
            XCTAssert(view.translatesAutoresizingMaskIntoConstraints)
            view.autoLayout { item in
                item.width.equal(to: 100)
            }
            XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
        }
        XCTContext.runActivity(named: "isActive control") { _ in
            let view = AL.View()
            XCTContext.runActivity(named: "All isActive should become true by default") { _ in
                let constraints = view.autoLayout { item in
                    item.size.equal(toSquare: 100)
                }
                XCTAssert(constraints.allSatisfy { $0.isActive })
            }
            XCTContext.runActivity(
                named: "All isActive should be false when activates: false"
            ) { _ in
                let constraints = view.autoLayout(activates: false) { item in
                    item.size.equal(toSquare: 100)
                }
                XCTAssert(constraints.allSatisfy { !$0.isActive })
            }
        }
    }
}
