import UIKit
/*
 Collection Types
 */

//create array has two methods
// first method
var firstInts = Array<Int>()
print(firstInts.count)
//second method
var someInts = [Int]()
someInts.append(30)
someInts = []

//创建一个带默认值的数组
var threeDoubles = Array(repeating: 0.0, count: 3)
print(threeDoubles)
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
//数组可以用+号来创建新数组
var sixDoubles = threeDoubles + anotherThreeDoubles
print(sixDoubles)

//通过数组字面量创建数组
var shoppingList:[String] = ["Eggs","Milk"]
var notTypeShoppingList = ["Egg","Milk","OC","Swift"]
print(notTypeShoppingList)

//访问和修改数组
if shoppingList.isEmpty {
    print("数组元素为空")
}
//append
shoppingList.append("Flower")
//+=
shoppingList += ["Cow","Pag"]
//retrieve 取回元素 【index】
var firstItem = shoppingList[0]
shoppingList[0] = "yeyangyang"
//print(shoppingList)
shoppingList[2...4] = ["kayouyou","jack","2","1"]
//print(shoppingList.count)
//insert
shoppingList.insert("test insert", at: 0)
print(shoppingList)
//remove 返回要删除的元素
let deletestr = shoppingList.remove(at: 1)
print(deletestr)
//removelast 移除最后一个元素
let lastStr = shoppingList.removeLast()
print(lastStr)
//迭代数组
for item in shoppingList {
    print(item)
}
//如果你想获取每个元素的index,使用enumerated返回的是tuple （index,value）
for (index,value) in shoppingList.enumerated() {
    print("item\(index + 1):\(value)")
}

// set 存储不同类型的值，无序且不重复的
// set存储的值必须是可hashable的
//每个元素的hashvalue在不同的程序执行中并不是一致的
print(shoppingList.hashValue)

//初始化set
var letters = Set<Character>()
letters.insert("q")
print(letters)

//通过一个数组字面量创建一个set
var favouriteGenres :Set<String> = ["Rock","Classical","Hiphop"]
print(favouriteGenres)

//set不能被数组字面量单独推断出，所以set的类型必须直白的声明
//不管怎么样，如果数组中元素是同一类型，则不必声明set的类型,因为数组的值都是同一类型，所以可以类型推断出set的类型
var favouriteColors:Set = ["red","purple","green"]

//移除单个元素
let removedItem = favouriteColors.remove("red")
//由于是可选值，所以需要解包
if let unwrappedItem = removedItem {
    print(unwrappedItem)//red
}
//移除所有的
//favouriteColors.removeAll();

//判断是否包含
if favouriteColors.contains("purple") {
    print("include 紫色")
}

//迭代set
for setItem in favouriteGenres.sorted() {
    print("\(setItem as Any)")
}

//intersection
//symmetricDifference
//union
//subtracting
let oddDIgits: Set = [1,2,3,4,5,6]
let evenDigits: Set = [0,2,4,6,8]
let singleDigits: Set = [2,3,5,7]

oddDIgits.union(evenDigits).sorted()
oddDIgits.subtracting(evenDigits)
oddDIgits.symmetricDifference(evenDigits)
oddDIgits.intersection(evenDigits)

//set membership and equality























































