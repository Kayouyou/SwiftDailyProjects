import UIKit

//定义一个基类
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise()  {
        
    }
}

let someVehicle = Vehicle()
print("Vehicle:\(someVehicle.description)")
class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true




