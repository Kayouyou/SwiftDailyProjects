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



































