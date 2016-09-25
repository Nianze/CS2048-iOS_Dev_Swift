// This is a single line comment
/* This is a
    multiline comment */

// VARIABLES ===============================================================

var thisIsModifiable = 1.0
thisIsModifiable += 123
let thisIsNOTModifiable = 1.0
// thisIsNOTModifiable = 123  // <- Generates an error!!

// Explicitly declaring type
var aDouble : Double = 123 // Float is another floating point numberical type
var anInt : Int = 1_000_000_000 // == 1000000000
var aString : String = "pepper12311"

// Optinoal variables
var canBeNil : String? = nil
canBeNil = "not nil anymore"
print(canBeNil!) // The "!" forces an unwrap of the optional and raises an error if the variable canBeNil == nil

// Collections
var anArray : [Double] = [1,2,3,4]
print(anArray[0]) // Zero indexed
anArray[1] = 123
var emptyArray = [Double]()

// Dictionary
var aDictionary : [String:Double] = ["one" : 1, "two" : 2]
print(aDictionary["one"]!) // will have a newline
print(aDictionary["one"]!, terminator: "") // will not have a newline


// CONTROL FLOW ===============================================================

if aDouble > 0.1 {
    print("is greater than 0.1")
} else {
    print("is not greater than 0.1")
}

switch aString {
case "Hello":
    print("aString == Hello")
case "multiple", "matches":
    print("switch can match multiple values")
case let localScopeValue where localScopeValue.hasPrefix("pepper"):
    print("matching a prefix")
default:
    print("Nothing above matched")
}


for i in 0...10 { // inclusive range
    print(i)
}

for i in 0..<10 { // non inclusive range
    print(i)
}

for arrayElem in anArray {
    print(arrayElem)
}

for (key, value) in aDictionary {
    print("key = \(key), value = \(value)")
}

// FUNTION =========================

func f(x : Double) -> Double {
    return x * x
}

/*
print(f(2.0))

func f3(x: Double) -> (timesTen: Double, oneTenth: Double) {
    return (x * 10, x / 10)
}

let ret = f3(10)
print(ret.oneTenth)
print(ret.timesTen)

func f4(x: Double, blockOfCode: (Double -> String)) {
    print(blockOfCode(x * 10))
}

f4(10.0, blockOfCode: { x in
    return "the value of x is \(x)"
})

f4(10.0, blockOfCode: { x in
    return "xxxxx value of x is \(x)"
})

f4(10.0) { x in
    return "the value of x is \(x)"
}


func f5(x: Double, y: Double, noName: ((Double, Double) -> String)) {
    print(noName(x + 1.0, y - 1.0))
}

f5(1.0, y: 3.0, noName: {x, y in return "test \(x) and \(y)"})
*/

// 2016 09 17

import Foundation

let parsedExpr = NSExpression (format: "log(x)")

let vars = ["x": 9.0]

// 2016 09 24

let defaultColorName = "red"
var userDefinedColorName: String? // defaults to nil

var colorNameToUse = userDefinedColorName ?? defaultColorName

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName

anArray.append(5)
anArray += [6,7,8]
anArray[4...6] = [1,2,3,4]
anArray






