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

@dynamicMemberLookup
public enum LBJSON: Equatable, Hashable {
    
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
            if case .array(let object) = self,
                index >= 0,
                index < object.count {
                return object[index]
            }
            return nil
        }
    }
    
    /// The read-only subscript using an String value.
    ///
    /// - parameter key: is an String value.
    /// - returns: an optional LBJSON enum instance.
    public subscript(key:String) -> LBJSON? {
        get {
            if case .dictionary(let object) = self {
                return object[key]
            }
            return nil
        }
    }
    
    /// The read-only subscript using an String value using dynamicMember.
    ///
    /// - parameter key: is an String value.
    /// - returns: an optional LBJSON enum instance.
    public subscript(dynamicMember key:String) -> LBJSON? {
        get {
            if case .dictionary(let object) = self {
                return object[key]
            }
            return nil
        }
    }
    
    /// `int` is a read-only computed property which tries to retrieve an `Int` associated value from the LBJSON object.
    ///
    /// - returns: an optional `Int` which has the associated value or `nil` if the value is not of this type.
    public var int: Int? {
        get {
            if case .number(let object) = self {
                return object.intValue
            }
            return nil
        }
    }
    
    /// `double` is a read-only computed property which tries to retrieve a `Double` associated value from the LBJSON object.
    ///
    /// - returns: an optional `Double` which has the associated value or `nil` if the value is not of this type.
    public var double: Double? {
        get {
            if case .number(let object) = self {
                return object.doubleValue
            }
            return nil
        }
    }
    
    /// `number` is a read-only computed property which tries to retrieve an `NSNumber` associated value from the LBJSON object.
    ///
    /// - returns: an optional `NSNumber` which has the associated value or `nil` if the value is not of this type.
    public var number: NSNumber? {
        get{
            if case .number(let object) = self {
                return object
            }
            return nil
        }
    }
    
    /// `bool` is a read-only computed property which tries to retrieve a `Bool` associated value from the LBJSON object.
    ///
    /// - returns: an optional `Bool` which has the associated value or `nil` if the value is not of this type.
    public var bool: Bool? {
        get {
            if case .number(let object) = self {
                return object.boolValue
            }
            return nil
        }
    }
    
    /// `string` is a read-only computed property which tries to retrieve an `String` associated value from the LBJSON object.
    ///
    /// - returns: an optional `String` which has the associated value or `nil` if the value is not of this type.
    public var string: String? {
        get {
            if case .string(let object) = self {
                return object
            }
            return nil
        }
    }
    
    /// `array` is a read-only computed property which tries to retrieve an `[LBJSON]` associated value from the LBJSON object.
    ///
    /// - returns: an optional array of `LBJSON` objects which has the associated value or `nil` if the value is not of this type.
    public var array: [LBJSON]? {
        get {
            if case .array(let object) = self {
                return object
            }
            return nil
        }
    }
    
    /// `dictionary` is a read-only computed property which tries to retrieve an `[String:LBJSON]` associated value from the LBJSON object.
    ///
    /// - returns: an optional dictionary with `String` keys and `LBJSON` objects which has the associated value or `nil` if the value is not of this type.
    public var dictionary: [String:LBJSON]? {
        get {
            if case .dictionary(let object) = self {
                return object
            }
            return nil
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
