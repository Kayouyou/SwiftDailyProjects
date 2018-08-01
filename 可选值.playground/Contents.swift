//: Playground - noun: a place where people can play

import UIKit

//enum Optional<Wrapped>{
//    case none
//    case some(Wrapped)
//}

extension Collection where Element:Equatable{
    //Optional<Index> 可以写成 Index?
    func index(of element:Element) -> Optional<Index> {
        var idx = startIndex
        while idx != endIndex {
            if self[idx] == element {
                return .some(idx)
            }
            formIndex(after: &idx)
        }
        //没有找到返回.none  也可以使用nil代替.none
        return nil //.none
    }
}

var myarray = ["one","two","three"]
let idx = myarray.index(of: "four")

//如果你得到的可选值不是.none现在想要取出可选值的实际的索引的话，你必须对其进行解包
switch myarray.index(of: "four") {
case .some(let idx)://简写形式 let idx?
    myarray.remove(at: idx)
case .none://简写形式 nil
    break
}

//if let 进行可选绑定  可以跟一个布尔限定语句搭配
if let idx = myarray.index(of: "four"),idx != myarray.startIndex {
    myarray.remove(at: idx)
}

//if let语句中可以绑定多个值，更赞的是后面的绑定值可以基于之前的成功解包的值来进行操作
let urlSting = "https://www.objc.io/logo.png"
//因为data的初始化方法可能会抛出错误，可以通过try？把它转变为一个可选值 多个let的任意部分也能拥有布尔值限定的语句
if let url = URL(string: urlSting),url.pathExtension == "png",
    let data = try? Data(contentsOf: url),
    let image = UIImage(data: data)
{
    UIImageView(image: image)
}

//while let和  if let非常的相似，它代表一个当条件返回nil时终止的循环
let arr = [1,2,3]
var iterator = arr.makeIterator()
while let i = iterator.next(){
//    print(i,terminator:" ")
}

//所以，一个for循环其实就是一个while循环，这样一来，for循环也支持布尔语句就是情理之中了
for i in 0..<10 where i % 2 == 0 {
//    print(i,terminator:"")
}

//双重可选值

let stringNumbers = ["1","2","three"]
let maybeInts = stringNumbers.map {Int($0)}
print(maybeInts)

for maybeint in maybeInts
{
    print(maybeint)
}

var iter = maybeInts.makeIterator()
while let maybeInt = iter.next(){
//    print(maybeInt,terminator:" ")
}

for case let i? in maybeInts {
    print(i)// 1 2
}

for case let .some(i) in maybeInts {
    print(i)// 1 2
}

//基于case的模式匹配可以让我们把在switch的匹配中用到的规则同样应用到if  for  while 上去
let j = 5
if case 0..<10 = j {
    print("\(j)在范围内")
}

//因为case匹配可以通过重载~=运算符来进行扩展，所以你可以将if case 和 for case进行一些有趣的扩展
struct Pattern{
    let s:String
    init(_ s:String) {
        self.s = s
    }
}
func ~=(pattern:Pattern,value:String) ->Bool{
    return value.range(of: pattern.s) != nil
}

let s = "Taylor Swift"
if case Pattern("Swift") = s {
    print("\(String(reflecting: s)) contains \"Swift\"")
}

//if var and while var 除了let之外，你还可以使用var来搭配if while 和 for 这样你就可以在语句猴子那个改变变量了
let number  = "1"
//注意：i会是一个本地的赋值复制，任何对i的改变将不会影响到原来的可选值 可选值是值类型 解包一个可选值做的事情是将它里面的值复制出来
if var i = Int(number) {
    i += 1
    print(i)
}
enum ArrayError: Error {
    case outOfStack
}
guard !myarray.isEmpty else { throw ArrayError.outOfStack }
//下面可以使用myarray[0]或myarray.first!

//可选链  oc中对nil发消息什么都不会发生，swift中我们可以通过可选链来达到同样的效果

let str:String? = "never say never"
let upper:String
if str != nil {
    upper = str!.uppercased()
}else{
    fatalError("no idea what to do now")
}

let lower = str?.uppercased().lowercased()

//如果uppercased()方法本身也返回一个可选值的话，你就需要在它后面加上?来表示正在链接的这个可选值

extension Int{
    var half:Int?{
        guard self < -1 || self > 1 else {
            return nil
        }
        return self/2
    }
}

20.half?.half?.half
let dictArray = ["nine":[1,2,3]]
dictArray["nine"]?[2]

let dictOfFunctions:[String:(Int,Int)->Int] = ["add":(+),"subtract":(-)]
dictOfFunctions["add"]?(1,1)

class TextField{
    private(set) var text = ""
    //didChange属性存储了一个回调函数，每当用户编辑文不时，这个函数就会被调用，因为文本框的所有者并不一定需要注册这个回调，所以该属性时可选值，它的初始值为nil
    var didChange:((String)->())?
    
    private func textDidChange(newText:String){
        text = newText
        //如果不是nil触发回调
        didChange?(text)
    }
}

struct Person{
    var name:String
    var age:Int
}

var optionalLisa:Person? = Person(name: "Lisa Simpson", age: 9)
if optionalLisa != nil{
    optionalLisa!.age += 1
}

//这种写法非常的繁琐，也很丑陋，特别注意：这种情况下你不能使用可选绑定，因为person是一个结构体
//它是一个值类型，绑定后的值只是原来的值的局部作用域的复制，对这个复制进行变更并不会影响原来的值
if var lisa = optionalLisa{
    //对lisa的变更不会改变optionalLisa中的属性
    lisa.age += 1
}
//以上的写法还是太过复杂，其实，你可以使用可选值链来进行赋值
optionalLisa?.age += 1

var a:Int? = 5
a? = 10
a
var b:Int? = nil
b? = 10
b

a = 10
a? = 10
//两者区别：前一种写法无条件将一个新值赋给变量，后一种写法只在a的值在赋值前不是nil的时候才生效

//nil合并运算符

let stringteger = "1"
let numb = Int(stringteger) ?? 0

let arrs = [1,2,3]
!arrs.isEmpty ? arrs[0] : 0
//第二种方案更加漂亮了且清晰
arrs.first ?? 0

//常规写法
arrs.count > 5 ? arrs[5] : 0

//不像first和last 通过索引值从数组获取元素不会返回Optional 但是我们可以对array进行扩展
extension Array{
    subscript(guarded idx:Int) -> Element?{
        guard(startIndex..<endIndex).contains(idx) else{
            return .none
        }
        return self[idx]
    }
}

//arrs[guarded:3] ?? 0

//合并操作也能进行链接，如果你有多个可选值，并且想要选择第一个非nil的值，你可以将他们按顺序合并
var i:Int?  = .none
var h:Int? = .none
var k:Int? = 42

i ?? h ?? k  //42

var m:Int? = nil
var n:Int? = 1

//这种方式常和if let配合使用
if let n = m ?? n{
    //if i != nil || j != nil
    print(n)
}

//swift 的？？运算符不支持这种类型不匹配的操作，如果我们只是为了在字符串插值中使用可选值这个特殊目的的话，添加一个我们自己的运算符也很简单

infix operator ??? : NilCoalescingPrecedence
public func ???<T>(optional:T?,defaultValue:@autoclosure ()-> String) -> String{
    switch optional {
    case let value?:
        return String(describing: value)
    case nil:
        return defaultValue()
    }
}

//可选值map

let characters:[Character] = ["a","b","c"]
String(characters[0])

//如果characters可能为空的话 我们就需要if let
var firstCharAsString:String? = nil
if let char = characters.first {
    firstCharAsString = String(char)
}

//可选map 当它不是nil时进行转换
let secondChar = characters.first.map {String($0)}

[0,2,3,4].reduce(0, +)

//可选值flatMap
let strNumbers = ["1","2","3","foo"]
let x = strNumbers.first.map {Int($0)}
print(x)//Optional(Optional(1))

let y = strNumbers.first.flatMap {Int($0)}
print(y)//Optional(1)

//这说明 flatMap和if let非常相似
let urlStr = "https://www.objc.io/logo.png"
let view = URL(string: urlStr).flatMap{try? Data(contentsOf: $0)}.flatMap{UIImage(data: $0)}.map{UIImageView(image: $0)}
if let vi = view {
    print(vi)
}

//使用flatMap过滤nil
let numbers = ["1","2","3","foo"]
numbers.compactMap{Int($0)}.reduce(0, +)

//可选值判等

let regex = "^hello$"
if regex.first == "^" {
    
}
//如果你在使用一个非可选值的时候，如果需要匹配可选值类型，swift总是会将它升级为一个可选值然后使用

//改进强制解包的错误信息
infix operator !!
func !!<T>(wrapped:T?,failureText:@autoclosure() -> String) -> T{
    if let x = wrapped {
        return x
    }
    fatalError(failureText())
}

//现在你可以写出更能描述问题的错误信息了
let ss = "foo"
/**
 let ii = Int(ss) !! "Excepting integer,got\"(s)\""
 */

//在调试版本中进行断言  选择发行版本中应用崩溃是很大胆的行为 通常在调试版本中进行断言 让程序崩溃  最终发型版本 会把它替换成零或者空数组
infix operator !?
func !?<T:ExpressibleByIntegerLiteral>(wrapped:T?,failureText:@autoclosure()-> String)->T{
    assert(wrapped != nil,failureText())
    return wrapped ?? 0
}
//下面的代码将在调试时触发断言 但是发行版本中打印0
let sss = "20"
let iii = Int(sss) !? "Expecting integer,got\"\(sss)\""

//对其字面量转换协议进行重载，可以覆盖不少能够有默认值的类型
//如果你想显式地提供一个不同的默认值，或者是为了非标准的类型提供这个操作符，我们可以定一个接受多元组为参数的版本,多元组中包含默认值和错误信息
func !?<T>(wrapped:T?,nilDefault:@autoclosure ()->(value:T,text:String))->T{
    assert(wrapped != nil ,nilDefault().text)
    return wrapped ?? nilDefault().value
}

Int(sss) !? (5,"Expecting integer")

//多灾多难的隐私解包可选值   常常用在类型后面加一个感叹号来表示 表示的是你使用它们时就自动强制解包的可选值 
//常用语xcode和interface BUilder 在viewcontroller中使用它们的方式
//









































