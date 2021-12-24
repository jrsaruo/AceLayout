//
//  Assertions.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/13.
//

import XCTest
import AceLayout

func assertEqual(_ constraints1: [NSLayoutConstraint],
                 _ constraints2: [NSLayoutConstraint],
                 file: StaticString = #file,
                 line: UInt = #line) {
    XCTAssertEqual(constraints1.count, constraints2.count, "count", file: file, line: line)
    for (constraint1, constraint2) in zip(constraints1, constraints2) {
        assertEqual(constraint1.firstItem,
                    constraint2.firstItem,
                    message: "constraint1.firstItem is not equal to constraint2.firstItem",
                    file: file,
                    line: line)
        assertEqual(constraint1.secondItem,
                    constraint2.secondItem,
                    message: "constraint1.secondItem is not equal to constraint2.secondItem",
                    file: file,
                    line: line)
        XCTAssertEqual(constraint1.isActive, constraint2.isActive, "isActive", file: file, line: line)
        XCTAssertEqual(constraint1.firstAttribute, constraint2.firstAttribute, "firstAttribute", file: file, line: line)
        XCTAssertEqual(constraint1.secondAttribute, constraint2.secondAttribute, "secondAttribute", file: file, line: line)
        XCTAssertEqual(constraint1.relation, constraint2.relation, "relation", file: file, line: line)
        XCTAssertEqual(constraint1.multiplier, constraint2.multiplier, "multiplier", file: file, line: line)
        XCTAssertEqual(constraint1.constant, constraint2.constant, "constant", file: file, line: line)
        XCTAssertEqual(constraint1.priority, constraint2.priority, "priority", file: file, line: line)
    }
}

private func assertEqual(_ layoutItem1: AnyObject?,
                         _ layoutItem2: AnyObject?,
                         message: @autoclosure () -> String = "",
                         file: StaticString = #file,
                         line: UInt = #line) {
    switch (layoutItem1, layoutItem2) {
    case let (view1 as AL.View?, view2 as AL.View?):
        XCTAssertEqual(view1, view2, message(), file: file, line: line)
    case let (layoutGuide1 as AL.LayoutGuide?, layoutGuide2 as AL.LayoutGuide?):
        XCTAssertEqual(layoutGuide1, layoutGuide2, message(), file: file, line: line)
    default:
        XCTAssert(false, message(), file: file, line: line)
    }
}
