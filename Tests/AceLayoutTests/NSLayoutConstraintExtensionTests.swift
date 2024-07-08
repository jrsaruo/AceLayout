//
//  NSLayoutConstraintExtensionTests.swift
//
//
//  Created by Yusaku Nishi on 2021/12/16.
//

import XCTest
import AceLayout

final class NSLayoutConstraintExtensionTests: XCTestCase {
    
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
    func testPriority() {
        let constraints = subview.autoLayout { item in
            item.width.equal(to: 100)
            item.height.equal(to: 100).priority(.defaultLow)
            item.center.equal(to: superview).priority(.defaultHigh)
        }
        XCTAssertEqual(
            constraints.map { $0.priority },
            [.required, .defaultLow, .defaultHigh, .defaultHigh]
        )
    }
}
