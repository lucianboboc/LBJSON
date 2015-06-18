//
//  LBJSONTests.swift
//  LBJSONTests
//
//  Created by Lucian Boboc on 4/21/15.
//  Copyright (c) 2015 Lucian Boboc. All rights reserved.
//

import UIKit
import XCTest
import LBJSON

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
        var jsonObj = ["key":"value"]
        var obj = LBJSON(object: jsonObj)
        XCTAssert(obj != nil, "object should not be nil")
    }
    
    func testObjectCanNotBeCreated() {
        var obj = LBJSON(object: nil)
        XCTAssert(obj == nil, "object should not be nil")
    }
    
    
    func testObjectArrayProperty() {
        var jsonObj = [1,2,3]
        var obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.array != nil, "object should not be nil")
    }
    
    func testObjectArraySubscriptAndIntProperty() {
        var jsonObj = [1,2,3]
        var obj = LBJSON(object: jsonObj)
        let first = obj?.array?[0]
        XCTAssert(first != nil, "object should not be nil")
        let value = first!.int
        XCTAssert(value != nil, "value should not be nil")
        XCTAssert(value! == 1, "value should be 1, it is \(value!)")
        
    }

    
    func testObjectDictionaryProperty() {
        var jsonObj = ["key":"value"]
        var obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.dictionary != nil, "object should not be nil")
    }
    
    
    func testObjectDictionarySubscriptAndStringProperty() {
        let key = "key"
        let dictValue = "value"
        var jsonObj = [key:dictValue]
        let obj = LBJSON(object: jsonObj)

        let first = obj?.dictionary?[key]
        XCTAssert(first != nil, "object should not be nil")
        let value = first!.string
        XCTAssert(value != nil, "value should not be nil")
        XCTAssert(value! == dictValue, "value should be 1, it is \(value!)")
        
    }
    
    func testObjectIntProperty() {
        var jsonObj = 1
        var obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.int != nil, "object should not be nil")
        XCTAssert(obj!.int == 1, "object should be 1")
    }
    
    
    func testObjectDoubleProperty() {
        var jsonObj = 1.5
        var obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.double != nil, "object should not be nil")
        XCTAssert(obj!.double == 1.5, "object should be 1.5")
    }
    
    
    func testObjectNumberProperty() {
        var jsonObj = 1
        var obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.number != nil, "object should not be nil")
        XCTAssert(obj!.number!.isEqualToNumber(NSNumber(int: 1)), "object should be 1")
    }
    
    func testObjectBoolProperty() {
        var jsonObj = true
        var obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.bool != nil, "object should not be nil")
        XCTAssert(obj!.bool == true, "object should be true")
    }
    
    
    func testObjectStringProperty() {
        var jsonObj = "str"
        var obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.string != nil, "object should not be nil")
        XCTAssert(obj!.string!.isEqualToString("str"), "object should be 'str'")
    }
    
    
    func testObjectNSStringProperty() {
        var jsonObj = "str"
        var obj = LBJSON(object: jsonObj)
        XCTAssert(obj?.str != nil, "object should not be nil")
        XCTAssert(obj!.str != nil, "object should be 1.5")
    }
    
}
