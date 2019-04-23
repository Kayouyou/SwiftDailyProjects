import UIKit

/*
 subscript
 */

struct Matrix {
    let rows: Int,columns: Int
    var grid : [Double]
    init(rows:Int,columns: Int) {
        self.rows = rows
        self.columns = columns
        self.grid = Array(repeating: 0, count: rows * columns)
    }
    func indexIsValid(row: Int,column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get{
            assert(indexIsValid(row: row, column: column),"Index out of range")
            return grid[(row * column) + column]
        }
        set{
            assert(indexIsValid(row: row, column: column),"Index out of range")
            grid[row * column + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0,1] = 1.5
matrix[1,0] = 3.2

print(matrix)
//这里会会触发assert
let someValue = matrix[2,2]
