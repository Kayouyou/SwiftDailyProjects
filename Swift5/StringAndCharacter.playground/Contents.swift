import UIKit
let threeMoreDoubleMarks = #"""
here are three more double quotes:""""
"""#
print(threeMoreDoubleMarks)

let linefeedescape = #"line1 \n line2"#
print(linefeedescape)

if !linefeedescape.isEmpty {
    print("字符不为空")
}

//字符串
for character in "Dog!🐩" {
    print(character)
}
//字符串可以通过传输一个character数组构造一个字符串
let catChraters: [Character] = ["C","a","t","!","🐈"]
let catString = String(catChraters)
print(catString)

// Concatenating Strings and Characters
// +=
let string1 = "hello"
let string2 = "there"
var welcome = string1 + string2
var instruction = "look over"
instruction += string2

//append  可以添加一个string或character给一个character变量
welcome.append("kayuoyou")

//可变,多行的必须以一个新的一行开始否者报错
let basStart = """
one
two
three
"""
print(basStart)

//string interpolation (插入)
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

// #原始字符串
print(#"write an interpolated string in sswift using \#(multiplier)"#)

//String indices endindex is a unvalid argument
let greeting = "Grid Tag!"
greeting[greeting.startIndex]
greeting[greeting.index(after: greeting.startIndex)]
greeting[greeting.index(before: greeting.endIndex)]

// we can access all characters in a string by using indices
for index in greeting.indices {
    print("\(greeting[index])",terminator:"")
}

//substring
var greetings = "Hello,World!"
let index = greetings.firstIndex(of: ",") ?? greeting.endIndex
let beiginning = greetings[..<index]
//beigining is substring
print(type(of: beiginning))
//convert substring to a string for long-term storage
let newString = String(beiginning)
print(type(of: newString))




