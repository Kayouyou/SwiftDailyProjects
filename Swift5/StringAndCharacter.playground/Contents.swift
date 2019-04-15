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








