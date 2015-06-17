//
//  LBJSON.swift
//  LBJSON
//
//  Created by Lucian Boboc on 4/21/15.
//  Copyright (c) 2015 Lucian Boboc. All rights reserved.
//

import Foundation

public enum LBJSON {
    
    case Array([LBJSON])
    case Dictionary([NSString:LBJSON])
    case Number(NSNumber)
    case String(NSString)
    case Null
    case Nil
    
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
                for (key:AnyObject, obj:AnyObject) in theObjects {
                    if let theKey = key as? NSString, let jsonObj = LBJSON(object: obj) {
                        myDict[theKey] = jsonObj
                    }
                }
                self = LBJSON.Dictionary(myDict)
            case let theObject as NSNumber:
                self = LBJSON.Number(theObject)
            case let theObject as NSString:
                self = LBJSON.String(theObject)
            case let theObject as NSNull:
                self = LBJSON.Null
            default:
                self = Nil
            }
            
        }else {
            return nil
        }
    }
    
    
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
    
    public var int: Int? {
        switch self {
        case .Number(let object):
            return object.integerValue
        default:
            return nil
        }
    }
    
    public var double: Double? {
        switch self {
        case .Number(let object):
            return object.doubleValue
        default:
            return nil
        }
    }
    
    public var number: NSNumber? {
        switch self {
        case .Number(let object):
            return object
        default:
            return nil
        }
    }
    
    public var bool: Bool? {
        switch self {
        case .Number(let object):
            return object.boolValue
        default:
            return nil
        }
    }
    
    public var string: NSString? {
        switch self {
        case .String(let object):
            return object
        default:
            return nil
        }
    }
    
    public var array: [LBJSON]? {
        switch self {
        case .Array(let object):
            return object
        default:
            return nil
        }
    }
    
    
    public var dictionary: [NSString:LBJSON]? {
        switch self {
        case .Dictionary(let object):
            return object
        default:
            return nil
        }
    }
}


extension LBJSON: Printable {
    
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
            for (key:NSString, value:LBJSON) in dictObject {
                allObjects[key] = value
            }
            return allObjects.description
        case .Number(let nrObject):
            return nrObject.description
        case .String(let strObject):
            return strObject.description
        case .Null:
            return "NSNull"
        default:
            return "Nil"
        }
    }
}

extension LBJSON: Equatable {}

public func ==(lhs: LBJSON, rhs: LBJSON) -> Bool {
    switch (lhs,rhs) {
    case (.Array(let leftObject),.Array(let rightObject)):
        if leftObject.count == rightObject.count {
            for (index,obj) in enumerate(leftObject) {
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
            var leftKeys = leftObject.keys.array.sorted { (obj1, obj2) -> Bool in
                return (obj1 as String) < (obj2 as String)
            }
            
            var rightKeys = rightObject.keys.array.sorted { (obj1, obj2) -> Bool in
                return (obj1 as String) < (obj2 as String)
            }
            
            for (index,leftKey) in enumerate(leftKeys) {
                if leftKey == rightKeys[index] {
                    var rightKey = rightKeys[index]
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
    case (.Null, .Null):
        return true
    case (.Nil, .Nil):
        return true
    default:
        return false
    }
}
