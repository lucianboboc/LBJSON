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
                self = Null
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