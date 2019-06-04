import UIKit

// Food -> RecipeIngredient -> ShoppingListItem  三级结构
class Food {
	var name: String
	init(name: String) {
		self.name = name
	}
	
	convenience init() {
		self.init(name:"[Unnamed]")
	}
}

//类类型没有默认的逐一成员构造器，所以food类提供了一个接受单一参数name的指定构造器，这个构造器可以使用给一个特定的名字来创建新的food实例
let nameMeat = Food(name: "Bacon")

let mysteryMeat = Food()
print(mysteryMeat.name)//[Unnamed]

class RecipeIngredient : Food {
	var quantity : Int
	init(name: String, quantity: Int) {
		self.quantity = quantity
		super.init(name: name)
	}
	
	//这里由于s使用了和food中指定构造器init(name:String)相同的形参，相当于重写了父类的指定构造器，因此必须在前面使用override修饰符
	override convenience init(name: String) {
		self.init(name:name,quantity:1)
	}
}

//这个例子中，ReceipeIngredient的父类是Food，它有一个便利构造器init()，这个便利构造器会被Re继承
let oneItem = RecipeIngredient()
let twoItem = RecipeIngredient(name: "Bacon")
let threeItem = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {
	var purchased = false
	var description : String {
		var output = "\(quantity) x \(name)"
		output += purchased ? "✔️" : "❌"
		return output
	}
}

//ShoppingListItem 没有定义构造器来为purchased提供初始值，因为添加到购物车的物品的初始状态总是未购买
//因为它为自己的所有属性都提供了默认值，并且自己没有定义任何构造器，所以它将自动继承所有父类的指定构造器和便利构造器

var breakfastList = [
	ShoppingListItem(),
	ShoppingListItem(name: "Bacon", quantity: 6),
	ShoppingListItem(name: "Milk"),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
	print(item.description)
}

//可失败的构造器 failable-initializers
let wholeNumber: Double = 12345.0
let pi = 3.1415926

if let valueMaintained = Int(exactly: wholeNumber) {
	print("\(wholeNumber) conversion to Int maintains value f \(valueMaintained)")
}


let valueChanged = Int(exactly: pi)

if valueChanged == nil {
	print("\(pi) conversion to Int dose not maintain value")
}

struct Animal {
	let species: String
	init?(species: String) {
		if species.isEmpty {
			return nil
		}
		self.species = species
	}
}

//枚举类型的可失败构造器
enum TemperatureUnit {
	case Kelvin,Celsius,Fahrenheit
	init?(symbol:Character) {
		switch symbol {
		case "K":
			self = .Kelvin
		case "C":
			self = .Celsius
		case "F":
			self = .Fahrenheit
		default:
			return nil
		}
	}
}

//带原始值的e枚举类型的可失败构造器:自带一个可失败的构造器，该可失败构造器会有一个合适的原始值类型的rawValue形参，选择找到相匹配的枚举成员，找不到则构造失败
//重写上面的例子
enum Temperature: Character {
	case Kelvin = "K",Celsius = "C",Fahrenheit = "F"
}

let ff = Temperature(rawValue: "F")
if ff != nil {
	print(ff!)
}

//构造可失败的传递

class Product {
	let name: String
	init?(name:String) {
		if name.isEmpty {return nil}
		self.name = name
	}
}

class CarItem: Product {
	let quality:Int
	init?(name:String,quantity: Int){
		if quantity < 1 {
			return nil
		}
		self.quality = quantity
		super.init(name: name)
	}
}


//重写一个可失败构造器
class Document {
	var name: String?
	init() {}
	init?(name: String) {
		if name .isEmpty {
			return nil
		}
		self.name = name
	}
}

//定义一个document的子类，重写了所有父类的指定构造器，重写确保了无论使用何种构造器在没有名字或者形参传入空字符串时，c生成的实例中的name属性总有初始值
class AutomaticallyNamedDocument: Document {
	//可以使用非e可构造失败的重写可失败构造器，但是反之不行
	override init() {
		super.init()
		self.name = "[Untitled]"
	}
	override init(name: String) {
		super.init()
		if name.isEmpty {
			self.name = "[Untitled]"
		} else {
			self.name = name
		}
	}
}

//通过闭包设置默认属性值
struct Chessboard {
	let boardColors: [Bool] = {
		var temporaryBoard = [Bool]()
		var isBlack = false
		for i in 1...8 {
			for j in 1...8 {
				temporaryBoard.append(isBlack)
				isBlack = !isBlack
			}
			isBlack = !isBlack
		}
		return temporaryBoard
	}()
	func squareIsBlackAt(row:Int ,column: Int) -> Bool {
		return boardColors[(row * 8) + column]
	}
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))


