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

for prefix in PrefixSequence(string: "Hello"){
    print(prefix)
}















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

