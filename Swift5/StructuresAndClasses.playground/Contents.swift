

import UIKit

/*
 结构体和类
 */

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//实例
let someResolution = Resolution()
let someValidMode = VideoMode()

//用点语法用来访问或赋值属性以及子属性

//结构体的逐一成员构造器,但是类没有
let vigin = Resolution(width: 200, height: 300)

//类是引用类型
let tenEighty = VideoMode()
tenEighty.resolution = vigin
tenEighty.interlaced = true
tenEighty.name = "10081"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print(tenEighty.frameRate)
print(alsoTenEighty.frameRate)

//检查两个实例是否相等
if tenEighty === alsoTenEighty {
    print("they are same")
}

struct FixedLengthRange {
    var firstValue: Int
    let length : Int
}

//由于是用var 所以可以改变它的firstValue的值，如果是用let，由于结构体是值类型，所以全部是常量，所有的属性初始化后都不能修改
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)

//但是类就不一样，类是引用类型

//计算属性

struct Point {
    var x = 0.0,y = 0.0
}

struct Size {
    var width = 0.0,height = 0.0
}

struct Rect {
    var  origin = Point()
    var  size  = Size()
    var center : Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        
//        set(newCenter) {
//            origin.x = newCenter.x - (size.width / 2)
//            origin.y = newCenter.y - (size.height / 2)
//        }
        //set可以简写，如果没有名字，则使用默认的newValue
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x),\(square.origin.y))")

//只读类型
struct Cuboid {
    
    var width = 0.0,height = 0.0,depth = 0.0
    //只读属性，可以省略get
    var volume : Double {
        return width * height * depth
    }
}

//属性观察


















