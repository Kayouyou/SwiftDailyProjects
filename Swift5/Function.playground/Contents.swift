
import UIKit

//函数的定义和调用
func greet(person:String) -> String{
    
    let greeting = "hello" + person + "!"
    return greeting
}

//简写
func greetAdvance(people:String) -> String{
    return "hai" + people + "!"
}
print(greetAdvance(people:"yeyangyang"))

//无参数函数
func sayHello() -> String{
    return "hello jim"
}

//带多个参数的函数
func greets(person:String,alreadyGreeted:Bool) -> String{
    if alreadyGreeted {
        return greet(person: person)
    }else{
        return greet(person: person)
    }
}

//无返回值函数，严格来说及时没有返回值，也返回了一个void值，是一个tuple类型 （）
func greetWithoutReturnValue(person: String){
    print("hello,\(person)")
}

//函数的返回值可以忽略

//返回多个返回值的函数
func minMax(array: [Int]) -> (min: Int,max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin{
            currentMin = value
        }else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin,currentMax)
}

let res = minMax(array: [1,2,3,4,5,6,7,8,9])
//返回的是一个元祖，所以可以点语法点出来
print(res.min)

//返回可选类型的元祖函数
func safeMinMax(array:[Int]) -> (min: Int,max: Int)? {
    
    if array.isEmpty {
        return nil
    }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin{
            currentMin = value
        }else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin,currentMax)
}

//使用可选绑定
if let r = safeMinMax(array: [1,2,3,4,5,6,7,8,9]) {
    print("min is \(r.min) and max is \(r.max)")
}

//函数的参数标签和参数名称
//指定参数标签

func someFunction(argumentLabel parameterName: Int) {
    //函数外部，argumentLabel
    //函数内部，parameterName代表参数的值
}

//带参数标签的函数
func greetFrom(person: String, from host: String) -> String {
    return "Hello \(person)! Glad you could visit from \(host)"
}

print(greetFrom(person: "lily", from: "kayouyou"))

//忽略参数标签使用 _ 下划线
func someFunctions(_ firstParameter: Int,secondParameter: Int) {
    
}
someFunctions(1, secondParameter: 2)

//默认参数函数:可以在参数的了类型后面加默认的参数值，如果有默认值，调用时可以忽略这个参数
func defaultFunc(defaultParameter: Int = 1,undefaultParameter: Int) {
    
}
defaultFunc(undefaultParameter: 2)

//可变参数函数:可以传入多个参数
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for num in numbers {
        total += num
    }
    return total
}

let rr = arithmeticMean(1,2,3,4,5,6,7)
print(rr)

//输入输出参数函数:允许在函数内部修改参数的值，并能在函数返回后持续有效

func swrapInt(_ a: inout Int,_ b: inout Int) {
    
    let temporaryA = a
    a = b
    b = temporaryA
}

//传输入输出参数
var aa = 1
var bb = 2
swrapInt(&aa, &bb)
print(aa)
print(bb)
//函数类型 简写
var tempfunc = swrapInt
//全写
//var tempMethod: (inout Int, inout Int) -> () = tempfunc
tempfunc(&aa,&bb)

//函数类型作为参数:允许把函数的部分实现交给函数调用者提供
func printMathResult(_ mathFunction: (Int,Int) -> Int,_ a: Int,_ b: Int){
    print("Result:\(mathFunction(a,b))")
}

//函数类型作为返回值
func stepForward(_ input: Int) -> Int {
    return input + 1
}

func stepBackward(_ input : Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}
//例子
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
print(moveNearerToZero(1))

//while循环
while currentValue != 0 {
    print("\(currentValue)")
    currentValue = moveNearerToZero(currentValue)
}

//函数嵌套,重写chooseStepFunction
func rewriteChooseStepFunctionByNest(backward:Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int {return input + 1}
    func stepBackward(input: Int) -> Int {return input - 1}
    return backward ? stepBackward : stepForward
}

