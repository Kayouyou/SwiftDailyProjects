//: Playground - noun: a place where people can play

import UIKit

//可变性
//let mutableArray:NSMutableArray = [1,2,3]
//for _ in mutableArray {
//    mutableArray.removeLastObject()
//}

//结构体
struct Point{
    var x:Int
    var y:Int
}

let origin = Point(x:0,y:0)

//因为swift中结构体拥有值语义，对于使用let定义的结构体变量，我们不能改变它的任何属性
//origin.x = 10

//可以使用var定义
var origin2 = Point(x:10,y:20)
origin2.x = 400

//结构体可以包含结构体
struct Size{
    var width:Int
    var height:Int
}

struct Rectangle{
    var origin:Point
    var size:Size
}

extension Point{
    //定义一个类属性，也就是说一个存在于类型本身上的属性，而不是实例属性
    static let Zero = Point(x: 0, y: 0)
}

let rect = Rectangle(origin: Point.Zero, size: Size(width: 320, height: 480))

//通过扩展定义自定义方法，就可以保留原来的初始化方法啦
extension Rectangle{
    init(x:Int=0,y:Int=0,width:Int,height:Int) {
        origin = Point(x: x, y: y)
        size = Size(width: width, height: height)
    }
}

let rect2 = Rectangle.init(origin: Point.Zero, size: Size(width: 200, height: 100))

//可变语义
//给结构体添加属性观察
var screen = Rectangle(width: 320, height: 480){
    didSet{
        print("screen changed:\(screen)")
    }
}
//我们仅仅改变结构体的某个属性，但是didSet也会被触发
screen.origin.x = 10

//由于标准库中集合类型也是结构一，它们可以同样的工作

var screens:[Rectangle]=[]{
    didSet{
        print("Screens array changed:\(screens)")
    }
}
screens.append(Rectangle(width: 200, height: 200))

//如果Rectangle是类的话，didSet就不会触发了 ，因为数字存储的引用不会发生改变，只是引用指向的对象发生了改变

//可变方法 假设为rantangle添加一个translate方法  用来偏移
//首先重载一个+操作符
func +(lhs:Point,rhs:Point)->Point{
    return Point(x:lhs.x + rhs.x,y:lhs.y + rhs.y)
}
screen.origin + Point(x: 10, y: 20)

//扩展Rectangle
extension Rectangle{
    //这里必须加mutating 不然没有办法给orgin进行赋值 （orgin = self.orgin的简写形式）
    //可以把self想象成一个传递给rantangle所有方法的额外的隐私参数，你不需要传递此参数，但是函数体内部你可以随时使用self 如果你想改变self，或改变self自身或嵌套的任何属性  必须将方法标记为mutating
    mutating func translate(by offset:Point){
        origin = origin + offset
    }
}
screen.translate(by: Point(x: 15, y: 15))

//很多情况下 一个方法有可变和不可变的版本
//不可变版本  非mutating版本  我们不改变self  而是创建一个复制 改变它  然后返回这个新的Rectangle
extension Rectangle{
    func translated(by offset:Point) -> Rectangle {
        var copy = self
        copy.translate(by: offset)
        return copy
    }
}
screen.translated(by: Point(x: 30, y: 30))

//mutating是如何工作的：inout参数
func translateByTwenty(rectangle:inout Rectangle){
    rectangle.translate(by: Point(x: 20, y: 20))
}
//接收矩形screen 在本地改变它的值 然后将新的值复制回去（覆盖原来的screen的值）这个行为和mutating方法如出一辙 实际上 mutating标记的方法也就是结构体上的普通方法 只不过隐私的self被标记为inout而已
translateByTwenty(rectangle: &screen)
screen

//注意：不能将let定义的矩形调用以上方法

var array = [Point(x: 0, y: 0),Point(x: 10, y: 10)]
//array[0] += Point(x: 20, y: 20)
array

//写时复制
final class Box<A>{
    var unbox:A
    init(_ value:A) {
        self.unbox = value
    }
}
//“在 Swift 中，我们可以使用 isKnownUniquelyReferenced 函数来检查某个引用只有一个持有者”
//OC类会直接返回false 可以创建一个简单的swift类 将OC对象封装到Swift对象中
var x = Box(NSMutableData())
isKnownUniquelyReferenced(&x)

//如果有多个引用的话 将会返回false
var y = x
isKnownUniquelyReferenced(&x)

struct MyData{
    private var _data:Box<NSMutableData>
    //一个计算属性
    var _dataForWriting : NSMutableData{
        mutating get{
            if !isKnownUniquelyReferenced(&_data) {
                _data = Box(_data.unbox.mutableCopy() as! NSMutableData)
                print("makeing a copy")
            }
            return _data.unbox
        }
    }
    init() {
        _data = Box(NSMutableData())
    }
    init(_ data:NSData) {
        _data = Box(data.mutableCopy() as! NSMutableData)
    }
}

extension MyData{
    mutating func append(_ byte:UInt8){
        var mutableByte = byte
        _dataForWriting.append(&mutableByte,length:1)
    }
}

var bytes = MyData()
var copy = bytes
for byte in 0..<5 as CountableRange<UInt8>{
    print("Appending 0x\(String(byte,radix:16))")
    bytes.append(byte)
}




































































