
import UIKit

/*
 闭包
 */
//sorted method

let names = ["Chirs","Alex","Ewa","Barry","Daniella"]
func backward(_ s1:String,_ s2:String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by:backward)

//闭包表达式
reversedNames = names.sorted(by: { (s1:String, s2: String) -> Bool in
    return s1 > s2
})

//由于当传一个闭包作为函数或方法作为n内联i闭包时，swift可以推断出参数类型以及返回类型，你永远可以不需要去写内联闭包的完整形式
reversedNames = names.sorted(by: {s1,s2 in return s1 > s2 })

//单表示式闭包可以省略return关键字
reversedNames = names.sorted(by: {s1,s2 in s1 > s2})

//参数名称简写 $0  $1  $2
reversedNames = names.sorted(by: {$0 > $1})

//操作符方法
reversedNames = names.sorted(by: >)

//尾随闭包: 必须是函数的最后一个参数
func someFunctionThatTakesAClosure(closure:() -> Void){
    
}
//没有使用尾随闭包
someFunctionThatTakesAClosure(closure: {
    
})
//使用尾随闭包
someFunctionThatTakesAClosure() {
    
}
//如果一个闭包表达是一个a函数或方法的唯一参数，你使用了尾随闭包，调用函数或方法时，你甚至不需要写方法名后的那一对括号
someFunctionThatTakesAClosure {
    
}

//尾随闭包改写上面示范例子
reversedNames = names.sorted(){$0 > $1}
reversedNames = names.sorted{$0 > $1}

//map 作用于数组
let digitNames = [0:"Zero",1:"One",2:"Two",3:"Three",4:"Four",5:"Five",6:"Six",7:"Seven",8:"Eight",9:"Nine"]
let numbers = [16,58,510]
//使用map函数改变数组内容并返回
let strings = numbers.map{ (number) -> String in
    var number = number
    var output = ""
    repeat {
        //字典下标取值返回的是可选值，所有用!强制解析
        output = digitNames[number % 10]! + output
        number /= 10
    }while number > 0
    return output
}

print(strings)

//捕获值
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    
    var runningTital = 0
    func incrementer() -> Int {
        runningTital += amount
        return runningTital
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
//返回的是一个函数
print(incrementByTen())

//闭包是引用类型
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
incrementByTen()

//逃逸闭包
var completeHandlers: [() -> Void] = []

//逃逸闭包在函数返回后调用
func someFunctionWithEscapingClosure(completeHandler:@escaping () -> Void){
    completeHandlers.append(completeHandler)
}
//非逃逸闭包
func someFunctionWithNoneescapingClosure(completeHandler: () -> Void){
    completeHandler()
}

class SomeClass {
    
    var x = 10
    func doSoemthing() {
        //逃逸闭包，需要直接显示引用self
        someFunctionWithEscapingClosure {
            self.x = 20
        }
        //非逃逸闭包则不需要显示引用self
        someFunctionWithNoneescapingClosure {
            x = 200
        }
    }
}

let instance = SomeClass()
instance.doSoemthing()
print(instance.x)

completeHandlers.first?()
print(instance.x)

//自动闭包
var customersInLine = ["Chris","Alex","Ewa","Barry"]
print(customersInLine.count)

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)

print("Now serving \(customerProvider())")
print(customersInLine.count)

//实际使用
//无自动闭包
func serveWithoutAutoclosure(customer custromProvider:() -> String) {
    print("Now serving \(customerProvider())")
}
serveWithoutAutoclosure { () -> String in
    customersInLine.remove(at: 0)
}

//有自动闭包
func serveWithAutoclosure(customer custromProvider:@autoclosure () -> String) {
    print("Now serving \(customerProvider())")
}
//调用函数就像用一个string的参数代替了闭包，参数被自动转换为一个闭包
serveWithAutoclosure(customer: customersInLine.remove(at: 0))

//可以组合h使用逃逸闭包和自动闭包
var customersOnLines: [() -> String] = []
func autoAndEscapingClosure(_ customerProvider:@autoclosure @escaping () -> String) {
    customersOnLines.append(customerProvider)
}
customersInLine = ["Chris","Alex","Ewa","Barry"]

//自动闭包：调用函数，参数直接传string，内部自动转为闭包
autoAndEscapingClosure(customersInLine.remove(at: 0))
autoAndEscapingClosure(customersInLine.remove(at: 0))

//逃逸闭包：延迟执行
for prider in customersOnLines {
    print("now is serving \(prider())")
}































