//
//  ViewController.swift
//  SwiftDoubleTree
//
//  Created by 叶杨 on 2017/2/7.
//  Copyright © 2017年 叶杨. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///没有使用struct，原因是结构体是值类型，不能拥有itself=
        let oneNode = TreeNode(1)
        oneNode.left = TreeNode(2)
        oneNode.right = TreeNode(3)
        
        let twoNode = oneNode.right
        twoNode?.left = TreeNode(4)
        twoNode?.right = TreeNode(5)
        
//        let sol = Solution()
//        let res = sol.leverOrder(oneNode)
        
        let res = TreeNode.leverOrder(oneNode)
        print(res)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

