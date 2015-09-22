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
/// - `Array` - this case have an associated value, an array of `LBJSON` objects.
/// - `Dictionary` - this case have an associated value, a dictionary with `NSString` type for keys and `LBJSON` objects for values.
/// - `Number` - this case have an associated value, an `NSNumber` object.
/// - `String` - this case have an associated value, an `NSString` object.
/// - `Nil` - this case doesn't have an associated value and is used in the failable initializer when the `JSON` param is `NSNull` or `nil` and as a default case.
public enum LBJSON {
    
    case Array([LBJSON])
    case Dictionary([NSString:LBJSON])
    case Number(NSNumber)
    case String(NSString)
    case Nil
    
    
    /// The initializer for the LBJSON object. It will parse the JSON and create a similar structure of LBSJON enum types with the correct associated values which could be retrieved very easy using the enum's properties.
    ///
    /// - parameter object: is the JSON AnyObject optional type used to initialize the LBJSON enum object.
    public init?(object:AnyObject?) {
        
        if let jsonObject: AnyObject = object {
            
            switch jsonObject {
            case let theObjects as NSArray:
                var myArray:[LBJSON] = []
                for obj:AnyObject in theObjects {
                    if let jsonObj = LBJSON(object: obj) {
                        myArray.append(jsonObj)
                    }
                }
                self = LBJSON.Array(myArray)
            case let theObjects as NSDictionary:
                var myDict:[NSString:LBJSON] = [:]
                for (key, obj): (AnyObject, AnyObject) in theObjects {
                    if let theKey = key as? NSString, let jsonObj = LBJSON(object: obj) {
                        myDict[theKey] = jsonObj
                    }
                }
                self = LBJSON.Dictionary(myDict)
            case let theObject as NSNumber:
                self = LBJSON.Number(theObject)
            case let theObject as NSString:
                self = LBJSON.String(theObject)
            case _ as NSNull:
                self = LBJSON.Nil
            default:
                self = Nil
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
            case .Array(let object) where object.count > index:
                return object[index]
            default:
                return nil
            }
        }
    }
    
    
    /// The read-only subscript using an NSString value.
    ///
    /// - parameter key: is an NSString value.
    /// - returns: an optional LBJSON enum instance.
    public subscript(key:NSString) -> LBJSON? {
        get {
            switch self {
            case .Dictionary(let object):
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
            case .Number(let object):
                return object.integerValue
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
            case .Number(let object):
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
            case .Number(let object):
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
            case .Number(let object):
                return object.boolValue
            default:
                return nil
            }
        }
    }
    
    /// `string` is a read-only computed property which tries to retrieve an `NSString` associated value from the LBJSON object.
    ///
    /// - returns: an optional `NSString` which has the associated value or `nil` if the value is not of this type.
    public var string: NSString? {
        get {
            switch self {
            case .String(let object):
                return object
            default:
                return nil
            }
        }
    }
    
    /// `str` is a read-only computed property which tries to retrieve a `String` associated value from the LBJSON object.
    ///
    /// - returns: an optional `String` which has the associated value or `nil` if the value is not of this type.
    public var str: Swift.String? {
        get {
            switch self {
            case .String(let object):
                return object as Swift.String
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
            case .Array(let object):
                return object
            default:
                return nil
            }
        }
    }
    
    /// `dictionary` is a read-only computed property which tries to retrieve an `[NSString:LBJSON]` associated value from the LBJSON object.
    ///
    /// - returns: an optional dictionary with `NSString` keys and `LBJSON` objects which has the associated value or `nil` if the value is not of this type.
    public var dictionary: [NSString:LBJSON]? {
        get {
            switch self {
            case .Dictionary(let object):
                return object
            default:
                return nil
            }
        }
    }
}


/// adoption of the Printable protocol to be able to generate a textual representation for an instance of LBJSON type.
extension LBJSON: CustomStringConvertible {
    
    public var description: Swift.String {
        switch self {
        case .Array(let arrObject):
            var allObjects:[Swift.String] = []
            for obj in arrObject {
                allObjects.append(obj.description)
            }
            return allObjects.description
        case .Dictionary(let dictObject):
            var allObjects = [NSString:LBJSON]()
            for (key, value): (NSString, LBJSON) in dictObject {
                allObjects[key] = value
            }
            return allObjects.description
        case .Number(let nrObject):
            return nrObject.description
        case .String(let strObject):
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
    case (.Array(let leftObject),.Array(let rightObject)):
        if leftObject.count == rightObject.count {
            for (index,obj) in leftObject.enumerate() {
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
    case (.Dictionary(let leftObject),.Dictionary(let rightObject)):
        if leftObject.count == rightObject.count {
            let leftArray = Array(leftObject.keys)
            let leftKeys = leftArray.sort { (obj1, obj2) -> Bool in
                return (obj1 as String) < (obj2 as String)
            }
            
            let rightArray = Array(rightObject.keys)
            var rightKeys = rightArray.sort { (obj1, obj2) -> Bool in
                return (obj1 as String) < (obj2 as String)
            }
            
            for (index,leftKey) in leftKeys.enumerate() {
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
    case (.Number(let leftObject), .Number(let rightObject)):
        return leftObject.isEqualToNumber(rightObject)
    case (.String(let leftObject), .String(let rightObject)):
        return leftObject.isEqualToString(rightObject as String)
    case (.Nil, .Nil):
        return true
    default:
        return false
    }
}
