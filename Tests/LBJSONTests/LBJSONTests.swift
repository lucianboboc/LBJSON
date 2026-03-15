//
//  LBJSONTests.swift
//  LBJSONTests
//
//  Modernized tests for LBJSON v1.0.0
//

import XCTest
@testable import LBJSON

final class LBJSONTests: XCTestCase {
    // MARK: - Object tests

    func testObjectCreation() {
        let jsonObj: [String: Any] = ["key": "value"]
        let json = LBJSON(object: jsonObj)
        XCTAssertNotNil(json, "LBJSON should not be nil for valid dictionary")
        XCTAssertEqual(json?.object?["key"]?.string, "value")
    }

    func testObjectNilInitialization() {
        let json = LBJSON(object: nil)
        XCTAssertNil(json, "LBJSON should be nil when initialized with nil")
    }

    func testObjectSubscript() {
        let jsonObj: [String: Any] = ["key": "value"]
        let json = LBJSON(object: jsonObj)
        let value = json?["key"]?.string
        XCTAssertEqual(value, "value", "Subscript should return the correct string")
    }

    func testDynamicMemberLookup() {
        let jsonObj: [String: Any] = ["name": "Lucian", "age": 30]
        let json = LBJSON(object: jsonObj)
        XCTAssertEqual(json?.name?.string, "Lucian")
        XCTAssertEqual(json?.age?.int, 30)
    }

    // MARK: - Array tests

    func testArrayCreation() {
        let jsonArray: [Any] = [1, 2, 3]
        let json = LBJSON(object: jsonArray)
        XCTAssertNotNil(json?.array, "LBJSON should be an array")
        XCTAssertEqual(json?.array?.count, 3)
    }

    func testArraySubscriptAndIntValue() {
        let jsonArray: [Any] = [1, 2, 3]
        let json = LBJSON(object: jsonArray)
        let first = json?[0]?.int
        XCTAssertEqual(first, 1, "First element should be 1")
    }

    // MARK: - Primitive types & Number Flexibility

    func testIntValue() {
        let json = LBJSON(object: 42)
        XCTAssertEqual(json?.int, 42)
        // Note: With NSNumber, 42 can also be retrieved as 42.0
        XCTAssertEqual(json?.double, 42.0)
        XCTAssertNil(json?.string)
    }

    func testDoubleValue() {
        let json = LBJSON(object: 3.14)
        XCTAssertEqual(json?.double, 3.14)
        // Note: With NSNumber, 3.14.intValue is 3
        XCTAssertEqual(json?.int, 3)
        XCTAssertNil(json?.string)
    }

    func testBoolValue() {
        let json = LBJSON(object: true)
        XCTAssertEqual(json?.bool, true)
        // Old behavior: true is 1
        XCTAssertEqual(json?.int, 1)
        XCTAssertNil(json?.string)
    }

    func testTruthinessInterchangeability() {
        // Test that integer 1 acts as true (Old Behavior)
        let jsonOne = LBJSON(object: 1)
        XCTAssertEqual(jsonOne?.bool, true)

        // Test that integer 0 acts as false
        let jsonZero = LBJSON(object: 0)
        XCTAssertEqual(jsonZero?.bool, false)
    }

    func testStringValue() {
        let json = LBJSON(object: "Hello")
        XCTAssertEqual(json?.string, "Hello")
        XCTAssertNil(json?.int)
        XCTAssertNil(json?.bool)
    }

    // MARK: - Null tests

    func testNullValue() {
        let json = LBJSON(object: NSNull())
        XCTAssertNotNil(json)
        XCTAssertTrue(json?.isNull ?? false)
    }

    func testInvalidObjectReturnsNil() {
        struct Dummy {}
        let json = LBJSON(object: Dummy())
        XCTAssertNil(json, "LBJSON should return nil for unsupported types")
    }

    // MARK: - Codable tests

    func testCodableRoundTrip() throws {
        let original: LBJSON = [
            "name": "Lucian",
            "age": 30,
            "isAdmin": true,
            "scores": [100, 95, 80],
            "info": [
                "city": "Lugano",
                "zip": "6900"
            ]
        ]

        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(LBJSON.self, from: data)

        XCTAssertEqual(decoded.name?.string, "Lucian")
        XCTAssertEqual(decoded.age?.int, 30)
        XCTAssertEqual(decoded.isAdmin?.bool, true)
        XCTAssertEqual(decoded.scores?[0]?.int, 100)
        XCTAssertEqual(decoded.info?["city"]?.string, "Lugano")
    }

    // MARK: - ExpressibleByLiteral tests

    func testDictionaryLiteral() {
        let json: LBJSON = ["key": "value", "number": 42]
        XCTAssertEqual(json["key"]?.string, "value")
        XCTAssertEqual(json["number"]?.int, 42)
    }

    func testArrayLiteral() {
        let json: LBJSON = [1, 2, 3]
        XCTAssertEqual(json[0]?.int, 1)
        XCTAssertEqual(json[1]?.int, 2)
        XCTAssertEqual(json[2]?.int, 3)
    }

    func testStringLiteral() {
        let json: LBJSON = "hello"
        XCTAssertEqual(json.string, "hello")
    }

    func testIntLiteral() {
        let json: LBJSON = 100
        XCTAssertEqual(json.int, 100)
    }

    func testDoubleLiteral() {
        let json: LBJSON = 3.14
        XCTAssertEqual(json.double, 3.14)
    }
    
    func testBoolLiteral() {
        let json: LBJSON = true
        XCTAssertEqual(json.bool, true)
    }

    // MARK: - Specific Codable Type Tests

    func testCodableInt() throws {
        let original: LBJSON = 42
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(LBJSON.self, from: data)
        XCTAssertEqual(decoded.int, 42)
    }

    func testCodableDouble() throws {
        let original: LBJSON = 3.1415
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(LBJSON.self, from: data)
        XCTAssertEqual(decoded.double, 3.1415)
    }

    func testCodableBool() throws {
        let original: LBJSON = true
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(LBJSON.self, from: data)
        XCTAssertEqual(decoded.bool, true)

        // Verify it didn't just decode as an Int 1
        let jsonString = String(data: data, encoding: .utf8)!
        XCTAssertEqual(jsonString, "true")
    }

    func testCodableArray() throws {
        let original: LBJSON = [1, 2, 3, "four", true]
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(LBJSON.self, from: data)

        XCTAssertEqual(decoded[0]?.int, 1)
        XCTAssertEqual(decoded[3]?.string, "four")
        XCTAssertEqual(decoded[4]?.bool, true)
    }
}
