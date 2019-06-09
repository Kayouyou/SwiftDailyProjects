import UIKit

//类型转换
//defining-a-class-hierarchy-for-type-casting

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String,director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles")
]

//类型检查 checking-type 用类型检查操作符 is 来检查一个实例是否属于特定子类型
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")

//向下转型 downcasing
//迭代library里的每个mediaitem，如果需要作为真正的Movie and Song来使用，而不仅仅是w作为MediaItem，所以z转换是必要的。
for item in library {
    //使用as?是因为转换可能会失败
    if let movie = item as? Movie {
        print("Movie: \(movie.name),dir.\(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name),by \(song.artist)")
    }
}

//Any & AnyObject 的类型转换
// Any 可以表示任何类型，包括函数类型
// AnyObject 可以表示任何类类型的实例

//使用any类型来和混合的不同类型一起工作，包含函数类型和非类类型
var things = [Any]()

things.append(0)
things.append(0.0)
things.append(43)
things.append(3.1415926)
things.append("Hello")
things.append((3.0,5.0))
things.append(Movie(name: "Jim", director: "Kayouyou"))
things.append({ (name: String) -> String in "hello,\(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a possible double value of \(someDouble)")
    case is Double:
        print("some other double value taht i do not wnat to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let movie as Movie:
        print("a movie called \(movie.name),dir.\(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

//any类型可以表示所有类型的值，包括可选类型，swift会在使用any类型表示一个可选值的时候给一个警告，如果你确实想使用any
//类型类承载可选值，你可以使用as操作符显式地转换为any类型
let optionalNumber: Int? = 3
things.append(optionalNumber) //有警告
things.append(optionalNumber as Any)//无警告

