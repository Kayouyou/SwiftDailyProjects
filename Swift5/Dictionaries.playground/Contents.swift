
import UIKit

/*
 字典
 */

//初始化字典
//简写,创建一个空字典
var nameOfINtegers = [Int:String]()
//完整写法
var nameOfIndex = Dictionary<Int,String>()
//print(type(of: nameOfINtegers))
//print(type(of: nameOfIndex))

//如果上下文提供了类型信息，可以使用[:]来创建一个空字典
nameOfINtegers[1] = "one"
nameOfINtegers = [:]
print(nameOfINtegers)

//类型标记可有可无
var airports:[String:String] = ["YYZ":"Toronto Pearson","DUB":"Dublin"]
//print(type(of: airports))

//更新字典
airports["LHR"] = "Londoon Heathrow"

//通过update更新,会返回旧的值
if let oldValue = airports.updateValue("Doublin Airport", forKey: "DUB") {
    print("the old value for dub was \(oldValue)");
}

//字典通过下标返回的值是可选值

//移除
if let removedDictItem = airports.removeValue(forKey: "DUB") {
    print("the removed airoort's name is \(removedDictItem)")
}

//迭代字典,forin返回的是一个元祖 tuple
for (airportCode,airportName) in airports {
    print("\(airportCode):\(airportName)")
}

//keys
for code in airports.keys {
    print("Airport code:\(code)")
}

//values
for value in airports.values {
    print("value:\(value)")
}

//如果你想使用字典的key和values作为数组
let codeArr = [String](airports.keys)
let valueArr = [String](airports.values)
print(codeArr,valueArr)


