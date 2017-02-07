//
//  DoubleTree.swift
//  SwiftDoubleTree
//
//  Created by 叶杨 on 2017/2/7.
//  Copyright © 2017年 叶杨. All rights reserved.
//

import Foundation

class TreeNode {

    public var value: Int = 0
    public var left : TreeNode?
    public var right : TreeNode?
    
    public init(_ value: Int){
        
        self.value = value
        self.left  = nil
        self.right = nil;
    }
}

extension TreeNode{
    
    class func leverOrder(_ root:TreeNode?) -> [[Int]] {
        
        guard let root = root else{
            
            return []
        }
        
        var  result = [[TreeNode]]()
        var level = [TreeNode]()
        
        level.append(root)
        
        while level.count != 0 {
            result.append(level)
            
            var nextLevel = [TreeNode]()
            for node in level {
                
                if let leftNode = node.left{
                    
                    nextLevel.append(leftNode)
                }
                
                if let rightNode = node.right {
                    
                    nextLevel.append(rightNode)
                }
            }
            
            level = nextLevel
        }
        
        let res = result.map{ $0.map{ $0.value}}
        
        return res
    }
}

class Solution{
    
    func leverOrder(_ root: TreeNode?) -> [[Int]] {
        
        guard let root = root else{
            
            return []
        }
        
        var  result = [[TreeNode]]()
        var level = [TreeNode]()
        
        level.append(root)
        
        while level.count != 0 {
            result.append(level)
            
            var nextLevel = [TreeNode]()
            for node in level {
                
                if let leftNode = node.left{
                    
                    nextLevel.append(leftNode)
                }
                
                if let rightNode = node.right {
                    
                    nextLevel.append(rightNode)
                }
            }
            
            level = nextLevel
        }
        
        let res = result.map{ $0.map{ $0.value}}
        
        return res
    }
}
