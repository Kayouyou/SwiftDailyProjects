//: Playground - noun: a place where people can play

import UIKit

//函数的灵活性
let myArray = [3,1,2]
myArray.sorted()//1 2 3

myArray.sorted(by:>)//3 2 1

//swift4 objcMembers 默认会加一个隐式 @objc

/*
 展示OC运行时
 */
@objcMembers
final class Person:NSObject{
    let first:String
    let last:String
    let yearOfBirth:Int
    init(first:String,last:String,yearOfBirth:Int) {
        self.first = first
        self.last = last
        self.yearOfBirth = yearOfBirth
    }
}

let people =
    [Person(first: "emil", last: "Young", yearOfBirth: 2002),
     Person(first: "lily", last: "Gray", yearOfBirth: 2000),
     Person(first: "Robert", last: "Barnes", yearOfBirth: 1985),
     Person(first: "Ava", last: "Barnes", yearOfBirth: 1998),]

let lastDescriptor = NSSortDescriptor(key: #keyPath(Person.last), ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
let firstDescriptor = NSSortDescriptor(key: #keyPath(Person.first), ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
let yearDescriptor = NSSortDescriptor(key: #keyPath(Person.yearOfBirth), ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))

//使用NSArray的sortedArray(using:)方法
let descriptors = [lastDescriptor,firstDescriptor,yearDescriptor]
(people as NSArray).sortedArray(using: descriptors)
//以上用了OC两个运行时特性：首先，key是OC的键路径，它其实是一个包含属性名字的链表；
//其次，OC运行时特性是键值编程，它可以在运行时通过键查找一个对象上的对应值

/*
 用swift实现
 */
var strings = ["hello","hallo","Hallo","Hello"]
strings.sort { $0.localizedStandardCompare($1) == .orderedAscending }
strings
strings.sorted(by:>)

//只想使用一个对象的某一个属性进行排序
people.sorted { $0.yearOfBirth < $1.yearOfBirth }
people

//使用lexicographicallyPrecedes 方法来进行实现，这个方法接收两个序列，并对他们执行一个电话薄的比较，也就是说，这个比较将顺次从两个序列中各取一个元素进行比较，直到发现不相等的元素
// 我们使用姓和名构建两个数组，然后使用lexicographicallyPrecedes比较它们
people.sorted { p0, p1 in
    let left = [p0.last,p0.first]
    let right = [p1.last,p1.first]
    return left.lexicographicallyPrecedes(right){
        $0.localizedStandardCompare($1) == .orderedAscending
    }
}
people

//以上用了差不多的行数重新实现了原来的那个排序方法 不过还有很大的改进空间 每次比较都构建一个数组是非常满意效率的 比较操作被写死的 而且使用方法我们将无法实现对yearOfBirth的排序

//函数作为数据

typealias SortDescriptor<Value> = (Value,Value) -> Bool

//现在我们定义比较两个person对象的排序描述符 可以比较出生和姓
let sortByYear:SortDescriptor<Person> = { $0.yearOfBirth < $1.yearOfBirth }
let sortByLastName:SortDescriptor<Person> = { $0.last.localizedStandardCompare($1.last) == .orderedAscending }

//手写描述符不是很好 定义一个函数 避免复制粘贴
func sortDescriptor<Value,Key>(key:@escaping(Value)->Key,by areInIncreasingOrder:@escaping(Key,Key)->Bool)->SortDescriptor<Value>{
    return {areInIncreasingOrder(key($0),key($1))}
}

//通过这个  我们可以用另一种方式定义sortByYear
let sortByYearAlt:SortDescriptor<Person> = sortDescriptor(key:{$0.yearOfBirth},by:<)
people.sorted(by: sortByYearAlt)

//我们还可以为所有的compareble类型定义一个重载版本的函数
func sortDescriptor2<Value,Key>(key:@escaping(Value)->Key) -> SortDescriptor<Value> where Key:Comparable{
    return {key($0) < key($1)}
}

let sortByYearAlt2:SortDescriptor<Person> = sortDescriptor2 {$0.yearOfBirth}

//上面两个返回的都是与布尔值相关的函数，但是foundation中的localizedStandaredCompare这样的API，所返回的是一个包含(升序，降序，相等)三种值的ComparisonResult的结果

func sortDescriptorA<Value,Key>(key:@escaping(Value)->Key,
                                ascending:Bool = true,
                                by comparator:@escaping(Key)->(Key)->ComparisonResult)->SortDescriptor<Value>{
    
    return { lhs ,rhs in
        let order:ComparisonResult=ascending
        ? .orderedAscending
        : .orderedDescending
        return comparator(key(lhs))(key(rhs)) == order
    }
}

//这样 我们就可以用简短的方式写排序描述符了
let sortByFirstN:SortDescriptor<Person> = sortDescriptorA(key: { $0.first
},by:String.localizedStandardCompare)
people.sorted(by: sortByFirstN)
people

//现在我们拥有了同样地表达能力，不过它是类型安全的，而且不依赖于运行时编程

//创建一个函数来将多个排序描述符合并为单个的排序描述符
func combine<Value>(sortDescriptors:[SortDescriptor<Value>]) ->SortDescriptor<Value>{
    
    return {lhs,rhs in
        for areInIncreasingOrder in sortDescriptors {
            if areInIncreasingOrder(lhs,rhs) {
                return true
            }
            if areInIncreasingOrder(rhs,lhs) {
                return false
            }
        }
        return false
    }
}
let combined:SortDescriptor<Person> = combine(sortDescriptors: [sortByLastName,sortByFirstN,sortByYearAlt])
print(combined)
people.sorted(by: combined)
people
































