//
//  LBJSONTests.swift
//  LBJSONTests
//
//  Created by Lucian Boboc on 4/21/15.
//  Copyright (c) 2015 Lucian Boboc. All rights reserved.
//

import UIKit
import XCTest
@testable import LBJSON

class LBJSONTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testObjectCanBeCreated() {
        let jsonObj = ["key":"value"]
        let obj = LBJSON(object: jsonObj)
        XCTAssert(obj != nil, "object should not be nil")
    }
    
    func testObjectCanNotBeCreated() {
        let obj = LBJSON(object: nil)
        XCTAssert(obj == nil, "object should not be nil")
    }
    
    
    func testObjectArrayProperty() {
        let jsonObj = [1,2,3]
        let obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.array != nil, "object should not be nil")
    }
    
    func testObjectArraySubscriptAndIntProperty() {
        let jsonObj = [1,2,3]
        let obj = LBJSON(object: jsonObj)
        let first = obj?.array?[0]
        XCTAssert(first != nil, "object should not be nil")
        let value = first!.int
        XCTAssert(value != nil, "value should not be nil")
        XCTAssert(value! == 1, "value should be 1, it is \(value!)")
        
    }

    
    func testObjectDictionaryProperty() {
        let jsonObj = ["key":"value"]
        let obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.dictionary != nil, "object should not be nil")
    }
    
    
    func testObjectDictionarySubscriptAndStringProperty() {
        let key = "key"
        let dictValue = "value"
        let jsonObj = [key:dictValue]
        let obj = LBJSON(object: jsonObj)

        let first = obj?.dictionary?[key]
        XCTAssert(first != nil, "object should not be nil")
        let value = first!.string
        XCTAssert(value != nil, "value should not be nil")
        XCTAssert(value! == dictValue, "value should be 1, it is \(value!)")
        
    }
    
    func testObjectIntProperty() {
        let jsonObj = 1
        let obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.int != nil, "object should not be nil")
        XCTAssert(obj!.int == 1, "object should be 1")
    }
    
    
    func testObjectDoubleProperty() {
        let jsonObj = 1.5
        let obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.double != nil, "object should not be nil")
        XCTAssert(obj!.double == 1.5, "object should be 1.5")
    }
    
    
    func testObjectNumberProperty() {
        let jsonObj = 1
        let obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.number != nil, "object should not be nil")
        XCTAssert(obj!.number!.isEqualToNumber(NSNumber(int: 1)), "object should be 1")
    }
    
    func testObjectBoolProperty() {
        let jsonObj = true
        let obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.bool != nil, "object should not be nil")
        XCTAssert(obj!.bool == true, "object should be true")
    }
    
    
    func testObjectStringProperty() {
        let jsonObj = "str"
        let obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.string != nil, "object should not be nil")
        XCTAssert(obj!.string!.isEqualToString("str"), "object should be 'str'")
    }
    
    
    func testObjectNSStringProperty() {
        let jsonObj = "str"
        let obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.str != nil, "object should not be nil")
        XCTAssert(obj!.str != nil, "object should be 1.5")
    }
    
}
