

import UIKit

/*
 枚举
 */

enum CompassPoint {
    case north
    case south
    case east
    case west
}

var directionToHead = CompassPoint.north
directionToHead = .east

//可以使用switch匹配枚举值
switch directionToHead {
case .north:
    print("lots of pplanets have a north")
case .east:
    print("lots of pplanets have a east")
default:
    print("not a safe place for human")
}

//迭代枚举类型：前提是遵循可迭代协议
enum Bevarage: CaseIterable {
    case coffee,tea,juice,milk,wine
}
//enum.allCases获取一个包含所有case的collection
let numberOfChoices = Bevarage.allCases.count
//循环打印每个case值
for caseValue in Bevarage.allCases {
    print(caseValue)
}

//枚举：关联值
enum Barcode {
    case upc(Int,Int,Int,Int)
    case qrCode(String)
}
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLIMN")
print(productBarcode)

//可以使用switch来check
switch productBarcode {
case .upc(let x, let y, let m, let n):
    print("UPC CODE:\(x),\(y),\(m),\(n)")
case .qrCode(let qrcodeStr):
    print("QR CODE:\(qrcodeStr)")
}

switch productBarcode {
case let .upc(x, y, m, n):
    print("UPC CODE:\(x),\(y),\(m),\(n)")
case let .qrCode(qrcodeStr):
    print("QR CODE:\(qrcodeStr)")
}

//Raw value : 原始值
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//隐式赋值原始值
//如果是int 则后面case则依次递增  如果是string，则后面case原始值默认是case的名称
enum Planet: Int {
    case mercury = 1,venus,earth,mars,jupiter,saturn,uranus
}

enum CompassPoints: String {
    case north,south,east,west
}
let earthOrder = Planet.earth.rawValue
print(earthOrder)
let sunsetDirection = CompassPoints.west.rawValue
print(sunsetDirection)

//用原始值初始化枚举实例,由于并不是每个原始值都会返回一个枚举case实例，所以返回的是一个可选值
let possiblePlanet = Planet(rawValue: 7)
print(possiblePlanet!)

let positionToFind = 11

if let somePlanet = Planet(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("mostly harmless")
    default:
        print("not a safe place for humans")
    }
}else{
    print("there isn't a planet at position \(positionToFind)")
}

//可递归的枚举
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression,ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression,ArithmeticExpression)
}

//另一种写法
//indirect enum ArithmeticExpression{
//    case number(Int)
//    case addition(ArithmeticExpression,ArithmeticExpression)
//    case multiplication(ArithmeticExpression,ArithmeticExpression)
//}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

//操作递归数据结构，使用递归函数
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))


