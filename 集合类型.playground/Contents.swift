//: Playground - noun: a place where people can play

import UIKit

//集合类型（Collection）指的是那些稳定的序列，它们能够被多次遍历且保持一致；
//集合中的元素也可通过下标索引的方式被获取到，下标通常是整数，不过索引也可以是一些不透明值
//集合和序列不同，集合类似不能是无限的
//Array Dictionary Set String CountableRange UnsafeBufferPointer 也是集合类型
//标准库外的一些类型也遵守了Collections协议，Data IndexSet

//自定义集合类型
//为队列设计协议
//一个能够将元素入队和出队的类型
protocol Queue{
    ///在self总所持有的元素的类型
    associatedtype Element
    ///将newElement入队到self
    mutating func enqueue(_ newElement:Element)
    ///从self出队一个元素
    mutating func dequeue()-> Element?
}

//队列的实现  一个很简单的先进先出队列

struct FIFOQueue<Element>:Queue{
    private var left:[Element] = []
    private var right:[Element] = []
    
    mutating  func enqueue(_ newElement:Element){
        right.append(newElement)
    }
    ///当队列为空时，返回nil
    ///复杂度 平摊o(1)
    mutating func dequeue() -> Element? {
        if left.isEmpty{
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

///上面实现使用两个栈（两个常规数组）来模拟队列行为

//遵守Collection协议
/**
 遵守collection协议至少需要声明一下
 1，startIndex 和 endIndex 属性
 2，至少能够读取你的类型中的元素的下标方法
 3，用来在集合索引之间进行步进的index(after:)方法
 */

extension FIFOQueue:Collection{
    
    public var startIndex:Int{return 0}
    public var endIndex:Int{return left.count + right.count}
    
    public func index(after i: Int) -> Int {
        precondition(i<endIndex)
        return i + 1
    }
    
    public subscript(position:Int)->Element{
        precondition((0..<endIndex).contains(position),"index oout of bounds")
        if position < left.endIndex{
            return left[left.count - position - 1]
        }else{
            return right[position - left.count]
        }
    }
}

//有了这几行代码，我们的队列已经拥有了超过40个方法和属性供我们使用了
var q = FIFOQueue<String>()
for x in ["1","2","foo","3"]{
    q.enqueue(x)
}

for s in q {
    print(s,terminator:"")
}

//我们可以将队列传递给接收序列的方法
var a = Array(q)
a.append(contentsOf:q[2...3])

//可以调用那些Sequence的扩展方法和属性
q.map {$0.uppercased()}
var qq = q.compactMap {Int($0)}
qq
q.filter {$0.count > 1}
q.sorted()
q.joined(separator: " ")

//也可以调用Collection的扩展方法和属性
q.isEmpty
q.count
q.first

//遵守ExpressibleByArrayLiteral协议
//当实习一个类似队列这样的集合类型时，最好也去实现一些ExpressibleByArrayLiteral协议，这样用户能够
//用他熟悉的[value1,value2]语法创建一个队列，
extension FIFOQueue:ExpressibleByArrayLiteral{
    public init(arrayLiteral elements: Element...) {
        left = elements.reversed()
        right = []
    }
}

//现在可以使用数组字面量来创建一个队列了

let queue:FIFOQueue = [1,2,3,4]
queue

//字面量

/**
 swift中字面量和类型的区别，这里的【1，2，3】b并不是一个数组，它只是一个“数组字面量”
 是一种写法，我们可以用它来创建任意的遵守ExpressibleByArrayLiteral的类型，在这个字面量
 还包括其他的字面量类型，比如能够创建任意遵守ExpressibleByIntegerLiteral的整数型字面量
 
 这些字面量有“默认”的类型，如果你不能指明类型，那些swift将假设你想要的就是默认类型
 但是这些只发生在你没有制定类型的情况下
 */

let byteQueue:FIFOQueue<UInt8> = [1,2,3]

//索引 表示集合中的位置
/**
 每个集合都有两个特殊的索引值，startIndex和endIndex 前者指定集合中第一个元素，后者制定集合中最后一个
 元素之后的位置，所以endinde并不是一个有效的下标索引；
 
 整数类型的index的唯一要求是，它必须实现Comparable，索引必须要有确定的顺序
 
 */






































































































































































