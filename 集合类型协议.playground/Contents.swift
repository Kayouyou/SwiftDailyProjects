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

