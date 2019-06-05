import UIKit

//class Residence {
//    var numberOfRows = 1
//}
//let john = Person()
//if let roomCOunt = john.residence?.numberOfRows {
//    print("john's residence has \(roomCOunt) room(s).")
//}

//defining-model-classes-for-optional-chaining

class Residence {
    var rooms = [Room]()
    var numberOfRooms:Int {
        return rooms.count
    }
    subscript(i:Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address:Address?
}

class Room {
    let name:String
    init(name:String) {
        self.name = name
    }
}

class Address {
    var buildingName:String?
    var buildingNumber:String?
    var street:String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if let buildinigNumbers = buildingNumber,let street = street {
            return "\(buildinigNumbers) \(street)"
        } else {
            return nil
        }
    }
}

class Person {
    var residence: Residence?
}

let jim = Person()
if let roomCount = jim.residence?.numberOfRooms {
    print("jim's residence has \(roomCount) room(s).")
}else {
    print("unable to retrieve the number of rooms")
}
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
jim.residence?.address = someAddress
//这里通过residence设定address属性也会失败，因为jim.residence = nil
print(jim.residence?.address ?? "baogang")

func createAddress() -> Address {
    print("Function was called.")
    let someAddress = Address()
    someAddress.buildingNumber = "30"
    someAddress.street = "gaopu"
    return someAddress
}
//不会输出任何东西，因为该函数并未被执行
jim.residence?.address = createAddress()

//calling-methods-through-optional-chaining

//printNumberOfRooms 没有返回值，但是具有隐式的返回类型void 意味着没有返回值的方法也会返回()或者空的元组
if jim.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

if (jim.residence?.address = someAddress) != nil {
    print("It was possible to set the address")
} else {
    print("It was not possible to set the address")
}

//accessing-subscripts-through-optional-chaining
if let firstRoomName = jim.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to receive the first room name")
}
