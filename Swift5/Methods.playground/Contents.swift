import UIKit

//方法
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter()
counter.increment()
counter.increment(by: 5)
counter.reset()

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0,y:5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the rihgt of the line where x == 1.0")
}

//改变枚举或结构体的属性值:虽然它们是值类型，但是可以使用mutating标记的func去改变值
struct Points {
    var x = 0.0,y = 0.0
    mutating func moveBy(x deltaX: Double,y deltaY:Double){
        x += deltaX
        y += deltaY
    }
}

//注意：你不可以改变一个常量的结构体类型，因为他的属性不能改变，及时它们是可变的属性
let fixedPoint = Points(x: 3, y: 2)

//cannot use mutating member on immutable value: 'fixedPoint' is a 'let' constant
//fixedPoint.moveBy(x: 2, y: 1)

//可变方法中给self赋值
struct PointSelf {
    var x = 0.0,y = 0.0
    mutating func move(x :Double,y: Double)
    {
        self = PointSelf(x: x + x, y: y + y)
    }
}

enum TriStateSwitch {
    case off,low,high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.low
ovenLight.next()
print(ovenLight)

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        }else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let  playerName: String
    func complete(level : Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Angle")
player.complete(level: 1)

print("highest un;ocked level is now \(LevelTracker.highestUnlockedLevel)")

player.complete(level: 5)

player = Player(name: "jim")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
}else {
    print("level 6 has not yet been unlocked")
}
