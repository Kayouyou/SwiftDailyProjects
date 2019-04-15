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

for character in "Dog!🐩" {
    print(character)
}


