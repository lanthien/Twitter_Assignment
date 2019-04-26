//
//  Twitter_AssignmentTests.swift
//  Twitter_AssignmentTests
//
//  Created by Diep Thien Lan on 4/24/19.
//  Copyright © 2019 Lan Thien. All rights reserved.
//

import XCTest
@testable import Twitter_Assignment

class Twitter_AssignmentTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testSplitMessage() {
        //Case: have a work more than 50 characters
//        let arr = try? Utilities.splitMessage("Scrollviews,however,receiveacontentInsettoaccountforthespacebetween the layout guide and anchor of a given direction, which allows us to scroll our content under translucent bars, but still scroll the content entirely into view. When UIKit performed its magic,")
//        XCTAssertNil(arr)
        
        do {
            let arr = try Utilities.splitMessage("Scroll views, however, receive a contentInset to account for the space between the layout guide and anchor of a given direction, which allows us to scroll our content under translucent bars, but still scroll the content entirely into view. When UIKit performed its magic, it set our scroll view’s contentInset property, which may or may not have conflicted with any inset we set. In iOS 11, Apple’s split apart those two properties: anything Apple sets (i.e. safe area adjustments) will be added to our contentInset (which we can now think of as “developer-assigned-content-Inset”), and the sum of those two values will be our adjustedContentInset, which is what the old contentInset used to be. As an aside, UIKit now has a method for adjustedContentInsetDidChange() on UIScrollView if you need to respond to the value changing.")
            //Case: string is split
            XCTAssertGreaterThan(arr.count, 1)

            //Case: All splited string have less than or equal 50 characters
            let filterArr = arr.filter { $0.count > 50 }
            XCTAssertEqual(filterArr.count, 0)
        } catch {

        }
    }
}
