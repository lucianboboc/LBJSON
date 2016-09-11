//
//  LBJSON.swift
//  LBJSON
//
//  Created by Lucian Boboc on 4/21/15.
//  Copyright (c) 2015 Lucian Boboc. All rights reserved.
//

import Foundation

/// `LBJSON` is an enum object which is used to parse a `JSON` object and values are saved as associated values in the enum cases.
/// To access the associated values without using the case statement, the provided variables can be used.
/// The `LBJSON` enum has the following cases:
///
/// - `array` - this case have an associated value, an array of `LBJSON` objects.
/// - `dictionary` - this case have an associated value, a dictionary with `String` type for keys and `LBJSON` objects for values.
/// - `number` - this case have an associated value, an `NSNumber` object.
/// - `string` - this case have an associated value, an `String` object.
/// - `null` - this case doesn't have an associated value and is used in the failable initializer when the `JSON` param is `NSNull` or `nil` and as a default case.
public enum LBJSON {
    
    case array([LBJSON])
    case dictionary([String:LBJSON])
    case number(NSNumber)
    case string(String)
    case null
    
    
    /// The initializer for the LBJSON object. It will parse the JSON and create a similar structure of LBSJON enum types with the correct associated values which could be retrieved very easy using the enum's properties.
    ///
    /// - parameter object: is the JSON Any optional type used to initialize the LBJSON enum object.
    public init?(object:Any?) {
        
        if let jsonObject:Any = object {
            
            switch jsonObject {
            case let theObjects as NSArray:
                var myArray:[LBJSON] = []
                for obj in theObjects {
                    if let jsonObj = LBJSON(object: obj) {
                        myArray.append(jsonObj)
                    }
                }
                self = LBJSON.array(myArray)
            case let theObjects as NSDictionary:
                var myDict:[String:LBJSON] = [:]
                for (key, obj) in theObjects {
                    if let theKey = key as? String, let jsonObj = LBJSON(object: obj) {
                        myDict[theKey] = jsonObj
                    }
                }
                self = LBJSON.dictionary(myDict)
            case let theObject as NSNumber:
                self = LBJSON.number(theObject)
            case let theObject as String:
                self = LBJSON.string(theObject)
            case _ as NSNull:
                self = LBJSON.null
            default:
                self = LBJSON.null
            }
            
        }else {
            return nil
        }
    }
    
    
    /// The read-only subscript using an Int value.
    ///
    /// - parameter index: is an Int value.
    /// - returns: an optional LBJSON enum instance.
    public subscript(index:Int) -> LBJSON? {
        get {
            switch self {
            case .array(let object) where object.count > index:
                return object[index]
            default:
                return nil
            }
        }
    }
    
    
    /// The read-only subscript using an String value.
    ///
    /// - parameter key: is an String value.
    /// - returns: an optional LBJSON enum instance.
    public subscript(key:String) -> LBJSON? {
        get {
            switch self {
            case .dictionary(let object):
                return object[key]
            default:
                return nil
            }
        }
    }
    
    /// `int` is a read-only computed property which tries to retrieve an `Int` associated value from the LBJSON object.
    ///
    /// - returns: an optional `Int` which has the associated value or `nil` if the value is not of this type.
    public var int: Int? {
        get {
            switch self {
            case .number(let object):
                return object.intValue
            default:
                return nil
            }
        }
    }
    
    /// `double` is a read-only computed property which tries to retrieve a `Double` associated value from the LBJSON object.
    ///
    /// - returns: an optional `Double` which has the associated value or `nil` if the value is not of this type.
    public var double: Double? {
        get {
            switch self {
            case .number(let object):
                return object.doubleValue
            default:
                return nil
            }
        }
    }
    
    /// `number` is a read-only computed property which tries to retrieve an `NSNumber` associated value from the LBJSON object.
    ///
    /// - returns: an optional `NSNumber` which has the associated value or `nil` if the value is not of this type.
    public var number: NSNumber? {
        get{
            switch self {
            case .number(let object):
                return object
            default:
                return nil
            }
        }
    }
    
    /// `bool` is a read-only computed property which tries to retrieve a `Bool` associated value from the LBJSON object.
    ///
    /// - returns: an optional `Bool` which has the associated value or `nil` if the value is not of this type.
    public var bool: Bool? {
        get {
            switch self {
            case .number(let object):
                return object.boolValue
            default:
                return nil
            }
        }
    }
    
    /// `string` is a read-only computed property which tries to retrieve an `String` associated value from the LBJSON object.
    ///
    /// - returns: an optional `String` which has the associated value or `nil` if the value is not of this type.
    public var string: String? {
        get {
            switch self {
            case .string(let object):
                return object
            default:
                return nil
            }
        }
    }
    
    /// `array` is a read-only computed property which tries to retrieve an `[LBJSON]` associated value from the LBJSON object.
    ///
    /// - returns: an optional array of `LBJSON` objects which has the associated value or `nil` if the value is not of this type.
    public var array: [LBJSON]? {
        get {
            switch self {
            case .array(let object):
                return object
            default:
                return nil
            }
        }
    }
    
    /// `dictionary` is a read-only computed property which tries to retrieve an `[String:LBJSON]` associated value from the LBJSON object.
    ///
    /// - returns: an optional dictionary with `String` keys and `LBJSON` objects which has the associated value or `nil` if the value is not of this type.
    public var dictionary: [String:LBJSON]? {
        get {
            switch self {
            case .dictionary(let object):
                return object
            default:
                return nil
            }
        }
    }
}


/// adoption of the Printable protocol to be able to generate a textual representation for an instance of LBJSON type.
extension LBJSON: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .array(let arrObject):
            var allObjects:[Swift.String] = []
            for obj in arrObject {
                allObjects.append(obj.description)
            }
            return allObjects.description
        case .dictionary(let dictObject):
            var allObjects = [String:LBJSON]()
            for (key, value) in dictObject {
                allObjects[key] = value
            }
            return allObjects.description
        case .number(let nrObject):
            return nrObject.description
        case .string(let strObject):
            return strObject.description
        default:
            return "Nil"
        }
    }
}

/// adoption of the Equatable protocol to be able to compare for value equality 2 instances of LBJSON type.
extension LBJSON: Equatable {}

public func ==(lhs: LBJSON, rhs: LBJSON) -> Bool {
    switch (lhs,rhs) {
    case (.array(let leftObject),.array(let rightObject)):
        if leftObject.count == rightObject.count {
            for (index,obj) in leftObject.enumerated() {
                if obj == rightObject[index] {
                    continue
                }else {
                    return false
                }
            }
            return true
        }else {
            return false
        }
    case (.dictionary(let leftObject),.dictionary(let rightObject)):
        if leftObject.count == rightObject.count {
            let leftArray = Array(leftObject.keys)
            let leftKeys = leftArray.sorted { (obj1, obj2) -> Bool in
                return (obj1 as String) < (obj2 as String)
            }
            
            let rightArray = Array(rightObject.keys)
            var rightKeys = rightArray.sorted { (obj1, obj2) -> Bool in
                return (obj1 as String) < (obj2 as String)
            }
            
            for (index,leftKey) in leftKeys.enumerated() {
                if leftKey == rightKeys[index] {
                    let rightKey = rightKeys[index]
                    if leftObject[leftKey] == rightObject[rightKey] {
                        continue
                    }else {
                        return false
                    }
                }else {
                    return false
                }
            }
            return true
        }else {
            return false
        }
    case (.number(let leftObject), .number(let rightObject)):
        return leftObject.isEqual(to: rightObject)
    case (.string(let leftObject), .string(let rightObject)):
        return leftObject.isEqual(rightObject)
    case (.null, .null):
        return true
    default:
        return false
    }
}
