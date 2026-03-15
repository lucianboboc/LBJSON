//
//  LBJSON.swift
//  LBJSON
//
//  Created by Lucian Boboc.
//  Swift 6–ready Codable + Literal + Sendable implementation
//

import Foundation

/// `LBJSON` is a Swift enum representing a JSON value.
/// It supports arrays, objects (dictionaries), strings, numbers, booleans, and null.
/// Provides literal initialization, dynamic member lookup, and Codable support.
@dynamicMemberLookup
public enum LBJSON: Equatable, Hashable, Sendable, Codable {

    case array([LBJSON])
    case object([String: LBJSON])
    case number(NSNumber)
    case string(String)
    case null

    // MARK: - Initialization

    /// Initialize a `LBJSON` from any Swift type.
    /// - Parameter object: Any optional object representing JSON.
    public init?(object: Any?) {
        guard let obj = object else {
            return nil
        }

        switch obj {
        case let arr as [Any]:
            self = .array(arr.compactMap { LBJSON(object: $0) })
        case let dict as [String: Any]:
            var result: [String: LBJSON] = [:]
            for (key, value) in dict {
                if let jsonValue = LBJSON(object: value) {
                    result[key] = jsonValue
                }
            }
            self = .object(result)
        case let value as NSNumber:
            self = .number(value)
        case let value as String:
            self = .string(value)
        case _ as NSNull:
            self = .null
        default:
            return nil
        }
    }

    // MARK: - Subscripts

    /// Access array elements by index.
    public subscript(index: Int) -> LBJSON? {
        guard case .array(let arr) = self, arr.indices.contains(index) else { return nil }
        return arr[index]
    }

    /// Access object elements by key.
    public subscript(key: String) -> LBJSON? {
        guard case .object(let dict) = self else { return nil }
        return dict[key]
    }

    /// Dynamic member access for objects.
    public subscript(dynamicMember key: String) -> LBJSON? {
        self[key]
    }

    // MARK: - Convenience Properties

    public var int: Int? {
        guard case .number(let value) = self else { return nil }
        return value.intValue
    }

    public var double: Double? {
        guard case .number(let value) = self else { return nil }
        return value.doubleValue
    }

    public var bool: Bool? {
        guard case .number(let value) = self else { return nil }
        return value.boolValue
    }

    public var string: String? {
        guard case .string(let value) = self else { return nil }
        return value
    }

    public var array: [LBJSON]? {
        guard case .array(let arr) = self else { return nil }
        return arr
    }

    public var object: [String: LBJSON]? {
        guard case .object(let dict) = self else { return nil }
        return dict
    }

    public var isNull: Bool {
        if case .null = self { return true }
        return false
    }

    // MARK: - Codable

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            self = .null
        } else if let value = try? container.decode(Bool.self) {
            self = .number(NSNumber(value: value))
        } else if let value = try? container.decode(Int.self) {
            self = .number(NSNumber(value: value))
        } else if let value = try? container.decode(Double.self) {
            self = .number(NSNumber(value: value))
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode([LBJSON].self) {
            self = .array(value)
        } else if let value = try? container.decode([String: LBJSON].self) {
            self = .object(value)
        } else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode LBJSON"
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .null:
            try container.encodeNil()
        case .number(let value):
            // Cast CChar to UInt8. UnicodeScalar(_:) for UInt8 is non-optional.
            let charCode = UInt8(bitPattern: value.objCType.pointee)
            let typeChar = UnicodeScalar(charCode)

            // 'c' is the Obj-C type encoding for BOOL/char
            // 'b' is used for C++ bool or newer Swift-bridged bool
            if typeChar == "c" || typeChar == "b" {
                try container.encode(value.boolValue)
            } else if CFNumberIsFloatType(value as CFNumber) {
                try container.encode(value.doubleValue)
            } else {
                try container.encode(value.intValue)
            }
        case .string(let value):
            try container.encode(value)
        case .array(let arr):
            try container.encode(arr)
        case .object(let dict):
            try container.encode(dict)
        }
    }
}

// MARK: - Literal Conformance

extension LBJSON: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, LBJSON)...) {
        var dict: [String: LBJSON] = [:]
        for (key, value) in elements { dict[key] = value }
        self = .object(dict)
    }
}

extension LBJSON: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: LBJSON...) {
        self = .array(elements)
    }
}

extension LBJSON: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

extension LBJSON: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .number(NSNumber(value: value))
    }
}

extension LBJSON: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .number(NSNumber(value: value))
    }
}

extension LBJSON: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .number(NSNumber(value: value))
    }
}

// MARK: - CustomStringConvertible

extension LBJSON: CustomStringConvertible {
    public var description: String {
        switch self {
        case .null: return "null"
        case .number(let nr): return nr.description
        case .string(let s): return "\"\(s)\""
        case .array(let arr):
            return "[" + arr.map { $0.description }.joined(separator: ", ") + "]"
        case .object(let dict):
            let entries = dict.map { "\"\($0)\": \($1.description)" }.joined(separator: ", ")
            return "{\(entries)}"
        }
    }
}
