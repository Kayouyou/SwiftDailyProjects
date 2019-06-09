import UIKit

//错误处理

//representing-and-throwing-errors
enum VendingMachineError: Error {
    case invalidSelection                  //选择无效
    case insufficientFunds(coinsNeeded:Int)//金额不足
    case outOfStock                        //缺货
}

//trowe error
//提示贩卖机还需要5个硬币
//throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

//propagating-errors-using-throwing-functions

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar" : Item(price: 12, count: 7),
        "Chips" : Item(price: 10, count: 4),
        "Pretzels" : Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name:String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

//因为vend方法会传递它抛出的任何错误，你要么使用try catch trr? 或 try! 要么继续将这些错误传递下去
let favouriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

//这个方法会查找某人最喜欢的食物，通过调用vend方法来尝试为他们购买，因为vend方法能抛出错误，所以在它前面加上了try关键字
func buyFavouriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favouriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

//throwing构造器能像throwing函数一样传递错误
struct PurchaseSnack {
    let name: String
    //构造器在构造过程中调用了throwing函数，并且通过传递到它的调用者来处理这些错误
    init(name: String,vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

//do-catch 处理错误
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavouriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection")
} catch VendingMachineError.outOfStock {
    print("Out of Stock")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficent funds. Please insert an additional \(coinsNeeded) coins")
} catch {
    print("Unexcepted error:\(error).")
}

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Invalid selection,out of stock,or not enough money")
    }
}

//如果vend抛出的是一个VendingMachineError类型的错误，则会打印错误信息
//否则就会抛给它的调用方，这个错误随后会被通用的catch语句捕获
do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error:\(error)")
}

//将错误转换为可选值
func someThrowingFunction() throws -> Int {
    return 1
}
let x = try? someThrowingFunction()
let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

//如果someThrowingFunction抛出一个错误，x和y的值都是nil，否则x和y都是该函数的的返回值
//try? 通过将错误转换成一个可选值来处理错误

//禁用错误传递 disbling-error-propagation
//指定清理操作 使用defer语句在即将离开当前代码块时执行一系列语句
//func processFile(filename: String) throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//    }
//}


