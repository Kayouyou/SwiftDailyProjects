//: Playground - noun: a place where people can play

import UIKit
import Foundation
//编码和解码

//自动遵守协议
struct Coordinate:Codable{//如果类型中所有的存储属性都是可编码的，那么swift自动生成代码，来实现Encodable和Decodable协议
    var latitude:Double
    var longitude:Double
}
//现在我们定义一个Placemark结构体，由于coordinate满足Codable协议 它也就自耦东满足codable了
struct Placemark:Codable{
    var name:String
    var coordinate:Coordinate
}

//Encoding
/**
 JSONEncoder 和 PropertyListEncoder 它们存在于Foundation中
 */

let places = [
    Placemark(name: "berlin", coordinate: Coordinate(latitude: 52, longitude: 13)),
    Placemark(name: "cape town", coordinate: Coordinate(latitude: -34, longitude: 18))]
do {
    let encoder = JSONEncoder()
    let jsonData = try encoder.encode(places)
    let jsonStr = String(data: jsonData, encoding: .utf8)
//    let jsonString = String(decoding: jsonData, as: UTF8.self)
    print(jsonStr!)
//    [{"name":"berlin","coordinate":{"longitude":13,"latitude":52}},{"name":"cape town","coordinate":{"longitude":18,"latitude":-34}}]
    
    do {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode([Placemark].self, from: jsonData)
        type(of: decoded)
        print(decoded)
    } catch  {
        print(error.localizedDescription)
    }
} catch {
    print(error.localizedDescription)
}














