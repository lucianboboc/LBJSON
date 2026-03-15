# LBJSON

[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/lucianboboc/LBJSON/blob/master/LICENSE.md)
[![Platform](https://img.shields.io/badge/platform-iOS%2017%2B-blue.svg)](https://github.com/lucianboboc/LBJSON)
[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![Concurrency](https://img.shields.io/badge/Concurrency-Sendable-brightgreen.svg)](https://developer.apple.com/documentation/swift/sendable)

LBJSON is a high-performance, Swift 6–ready framework that uses a recursive enum to represent JSON data. It bridges the gap between strict Swift typing and the flexible nature of JSON by providing Objective-C style "truthiness" within a modern, type-safe API.

## Features

- **Flexible Truthiness**: Automatically handles `1/0` as `true/false` using internal `NSNumber` bridging.
- **Swift 6 Ready**: Fully `Sendable` for safe use in concurrent environments and actors.
- **Dynamic Access**: Support for `@dynamicMemberLookup` (dot notation) and standard subscripts.
- **Native Codable**: Seamless integration with `JSONDecoder` and `JSONEncoder`.
- **Literal Support**: Initialize complex JSON structures directly using Swift literals (ExpressibleBy...Literal).
- **Type-Safe Getters**: Convenient access via `.string`, `.int`, `.bool`, `.double`, `.array`, and `.object`.

---

## Installation

### Swift Package Manager (SPM)

LBJSON is distributed exclusively via Swift Package Manager.

1. Open Xcode → **File** → **Add Packages…**
2. Enter the repository URL: `https://github.com/lucianboboc/LBJSON`
3. Select the version or branch you want (e.g., `v1.0.0` or `main`).
4. Add it to your target.

---

## Usage Guide

### Initializing from Literals
LBJSON allows you to define complex JSON structures using native Swift syntax.

```swift
let user: LBJSON = [
    "name": "Lucian",
    "age": 35,
    "isAdmin": true,
    "scores": [100, 95, 80],
    "metadata": [
        "city": "Milano",
        "zip": 20219
    ]
]
```

## Accessing values
You can access nested data using dynamic member lookup or traditional subscripts.

```swift
// Dynamic member lookup (dot notation)
let name = user.name?.string        // "Lucian"
let city = user.metadata?.city?.string // "Milano"

// Standard subscripts
let firstScore = user["scores"]?[0]?.int // 100

// Flexible truthiness (1 acts as true, 0 acts as false)
if user.isAdmin?.bool == true {
    print("User is an admin")
}
```

## Codable support
LBJSON works natively with `JSONEncoder` and `JSONDecoder`. It correctly preserves Boolean types vs. Numeric types during encoding.

```swift
// Encoding to Data
let jsonData = try JSONEncoder().encode(user)

// Decoding from Data
let decoded = try JSONDecoder().decode(LBJSON.self, from: jsonData)
print(decoded.name?.string ?? "Unknown")
```

## Concurrency (Swift 6)
Because LBJSON is `Sendable`, you can safely pass JSON objects across Actors and Task boundaries.

```swift
func processDriverData(_ data: LBJSON) async {
    // Safe to use in an async context
    let name = data.name?.string
    await MainActor.run {
        self.label.text = name
    }
}
```

## Initialization from `Any?`
Useful when working with legacy `JSONSerialization` results.

```swift
let raw: Any = ["status": "ok", "code": 200]
if let json = LBJSON(object: raw) {
    print(json.status?.string) // "ok"
}

// Handles Null and unsupported types safely
let nullJSON = LBJSON(object: NSNull()) // Results in .null
let invalid = LBJSON(object: MyCustomClass()) // Results in nil
```

## Safety & Edge Cases
LBJSON is designed to handle "dirty" data from legacy `JSONSerialization` calls safely

```swift
// 1. Bridges NSNull to the .null enum case
let fromNSNull = LBJSON(object: NSNull()) 
print(fromNSNull?.isNull) // true

// 2. Returns nil (fails) for types that aren't JSON-compatible
struct NonJSON {}
let invalid = LBJSON(object: NonJSON()) // nil

// 3. Gracefully handles actual Swift nil
let nothing = LBJSON(object: nil) // nil
```

## License

LBJSON is released under the [MIT License](https://github.com/lucianboboc/LBJSON/blob/main/LICENSE.md). Enjoy!
