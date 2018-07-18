//: Playground - noun: a place where people can play

import UIKit

//在闭包中使用集合
/*
 扩展sequence 一个方法 用于去除数组重复元素 但是保证顺序
 */
extension Sequence where Element:Hashable{
    func unique() -> [Element] {
        var seen:Set<Element> = []
        return filter{element in
            if seen.contains(element){
                return false
            }else{
                seen.insert(element)
                return true
            }
        }
    }
}
/*
 上面的方法我们可以找到序列中的所有的不重复的元素，并且维持他们原来的顺序，在我们传递给
 filter的闭包中，我们使用了一个外部的seen变量
 */
[1,2,3,4,4,3,2,1,1,5,6,7,8,2,1].unique()

// Range
/*
 不包含 ..<
 */
let singleDigtNumbers = 0..<10
Array(singleDigtNumbers)

/*
 包含 ...
 */
let lowercaseLetters = Character("a")...Character("z")
print(lowercaseLetters)

//let fromZero = 0...8
//let upToZ = ..<Character("z")

singleDigtNumbers.contains(9)
lowercaseLetters.overlaps("c"..<"f")

//可数范围
/*
Range 和 ClosedRange不是序列也不是集合类型
..<范围确实是序列，因为它其实是一个CountableRange<int>
 CountableRange和Range很相似，只不过它还需要一个附加约束
 它的元素类型需要遵守Strideable协议（以整数为步长）
 swift将这类功能更强的范围叫做可数范围，因为只有这类范围可以被迭代
 */

for i in 0..<10{
    print("\(i)")
}

//范围表达式
let arr = [1,2,3,4]
arr[2...]
arr[..<1]
arr[1...2]

//这种写法能够正常工作，因为Collection协议里对应的下标操作声明中，所接收的是一个RangeExpression的参数，而不是上述八个具体类型中的某一个
arr[...]
//这个其实是swift4.0 的特殊实现，这种无边界范围还不有效的RangeExpression类型，不过它应该遵守RnageExpression协议
type(of: arr)





































































