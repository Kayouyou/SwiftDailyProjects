//: Playground - noun: a place where people can play

import UIKit
/*
 集合类型协议
 Array Dictionary Set 都是建立在一系列由Swift标准库提供的用来处理元素序列的抽象之上的
 */

//序列
//Sequence协议是集合类型结构中的基础，一个序列代表的是一系列具有相同类型的值，你可以对这些值进行迭代
//满足Sequence协议的要求十分简单，你需要做的所有事情就是提供一个返回迭代器的makeIterator()方法
//迭代器 每次产生一个值，并且当遍历序列时对遍历状态进行管理，在iteratorProtocol协议中唯一的一个方法是next（）这个方法在每次被调用时返回序列的下一个值，当序列被耗尽时，next()函数返回nil

//遵守序列协议

//自定义一个iterator
struct PrefixIterator:IteratorProtocol{
    let string:String
    var offset:String.Index
    init(string:String) {
        self.string = string
        offset = string.startIndex
    }
    mutating func next() -> Substring? {
        guard offset < string.endIndex else {
            return nil
        }
        offset = string.index(after: offset)
        return string[..<offset]
    }
}

//自定义一个sequence
struct PrefixSequence:Sequence{
    let string: String
    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
}

//使用for循环迭代 优雅输出字符的每个前缀
for prefix in PrefixSequence(string: "Hello"){
    print(prefix)
}

//我们可以对它执行sequence的所有操作
PrefixSequence(string:"kayoyo").map {$0.uppercased()}

//迭代器和值语义
//标准库中大部分迭代器都是具有值语义的，不过也有例外存在

let seq = stride(from: 0, to: 10, by: 1)
type(of: seq)
var i1 = seq.makeIterator()
i1.next()
i1.next()

var i2 = i1
//现在原有的迭代器和新复制的迭代器是分开且独立的了
i1.next()
i1.next()
i2.next()
i2.next()

//现在看一个不具有值语义的迭代器，它将用来将原来的迭代器进行封装的迭代器，它可以用来将原来的迭代器的具体类型摸消掉
var i3 = AnyIterator(i1)
var i4 = i3

//这种情况，原来的迭代器和复制后的迭代器并不是独立的，因为实际的迭代器不再是一个结构体，anyiterator并不具有值语义，anyiterator中用来存储原来迭代器的盒子对象是一个类实例
i3.next()
i4.next()
i3.next()

//自定义类型的斐波那契数列迭代器
/**
struct FibsIterator: IteratorProtocol {
    var state = (0, 1)
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}
*/

//基于函数的迭代器和序列
//anyiterator还有另外一个初始化方法，那就是直接接受一个next函数作为参数，与对应的anysequence类型结合使用，我们可以做到不定义任何新的类型就能创建迭代器和序列
//与自定义类型的区别是：自定义的结构体具有值语义，使用anyiterator的没有
func fibsIterator()->AnyIterator<Int>{
    var state = (0,1)
    return AnyIterator{
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

//anysequence提供一个接受返回值为迭代器的函数作为输入的初始化方法
let fib = AnySequence(fibsIterator)
Array(fib.prefix(10))

//另外一种方法是使用sequence函数
let fib2 = sequence(state: (0,1)) { (state:inout(Int,Int)) -> Int? in
    let upcomingNumber = state.0
    state = (state.1, state.0 + state.1)
    return upcomingNumber
}

Array(fib2.prefix(10))


//无限序列

//子序列 Sequence 还有另外一个关联类型，叫做SubSequence
//扩展一个方法  检查一个序列的开头和结尾是否以同样的N个元素开始
extension Sequence where Element:Equatable,SubSequence:Sequence,SubSequence.Element == Element{
    func headMirrorsTail(_ n:Int) -> Bool {
        let head = prefix(n)
        let tail = suffix(n).reversed()
        //用来比较的elementsEqual方法只能在外面告诉编译器子序列也是一个序列 并且他的元素和原序列的元素类相同的情况下才能工作（序列中的类型已经遵守了equaltable）
        return head.elementsEqual(tail)
    }
}

[1,2,3,4,2,1].headMirrorsTail(2)

//链表 作为自定义序列的例子，让我们来用间接枚举实现一个最基础的数据结构，单向链表
//一个链表的节点有两种可能：要么是一个节点包含了值及对下一个节点的引用，要么他代表链表的结束

enum List<Element>{
    case end
    indirect case node(Element,next:List<Element>)
}

//这里使用indirect关键字可以告诉编译器这个灭局值node应该被看做引用
//swift中枚举是值类型，这意味着一个枚举值直接在变量中持有它的值，而不是持有一个指向位置的引用
//但是值类型不能循环引用自身，否则编译器就无法计算它的尺寸，indirect关键字允许一个枚举成员能够被当做引用这样一来，它就可以持有自己了

let enmptyList = List<Int>.end
let oneElementList = List.node(1, next: enmptyList)

//创建一个方法为了使用方便
extension List{
    func cons(_ x:Element) -> List {
        return .node(x,next:self)
    }
}

let list = List<Int>.end.cons(1).cons(2).cons(3)

//看起来很丑陋，我们改造一下 目标是能用数组字面量的方式初始化一个链表
//首先对输入数组进行逆序操作，然后使用reduce函数，并已.end为初始值，来将元素一个一个添加到链表中
extension List:ExpressibleByArrayLiteral{
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end){partialList,element in
            partialList.cons(element)
        }
    }
}

let list2:List = [3,2,1]

//这个列表有个特征，它是持久的 节点是不可变的  一旦它们被创建 你就无法在进行更改了

let list3:List = [4,5,6]

//链表共享
//链表的不可变性的关键就是这里，假设可以改变链表，那共享就会出现问题
//继续扩展list
extension List{
    
    mutating func push(_ x:Element){
        self = self.cons(x)
    }
    
    mutating func pop()-> Element?{
        switch self {
        case .end:
            return nil
        case let .node(x,next:tail):
            self = tail
            return x
        }
    }
}

//链表不是具有持久性和不可变星吗？这些可变方法其实并没有改变链表本身，它们改变的只是变量所持有的节点到底是哪一个

var stack:List<Int> = [6,5,4]
var a = stack
var b = stack
a.pop()//6
a.pop()//5
a.pop()//4
a.pop()//nil

//stack.pop()//6
//stack.pop()//5
stack.push(3)

b.pop()//6
b.pop()//5
b.pop()//4
b.pop()//nil
b

stack.pop()
stack.pop()
stack.pop()
stack.pop()

//这足以说明值和变量之间的不同，列表节点是值，它们不会改变

//让 list遵守Sequence 我们只需提供一个next方法 就能一次性地使它遵守iteratorProtocol和sequence协议

extension List:IteratorProtocol,Sequence{
    mutating func next() -> Element? {
        return pop()
    }
}

//现在你就能在列表上使用 for in 了

let list4:List = ["1","2","3"]
for x in list4 {
    print("\(x)",terminator:" ")
}

//同时得益于协议扩展的强大特性，我们可以在list上使用很多标准库中的函数
list4.joined(separator: ",")
list4.contains("2")
print(list4.flatMap {Int($0)})
list4.elementsEqual(["1","2","3"])

































































//一个实用的扩展，把Substring转化为string
//https://imtx.me/archives/2382.html   Substring 介绍链接
//extension String {
//    public func substring(from index: Int) -> String {
//        if self.characters.count > index {
//            let startIndex = self.index(self.startIndex, offsetBy: index)
//            let subString = self[startIndex..<self.endIndex]
//
//            return String(subString)
//        } else {
//            return self
//        }
//    }
//}

