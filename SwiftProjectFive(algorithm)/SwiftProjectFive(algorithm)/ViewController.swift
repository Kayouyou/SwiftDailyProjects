//
//  ViewController.swift
//  SwiftProjectFive(algorithm)
//
//  Created by 叶杨杨 on 2017/2/7.
//  Copyright © 2017年 叶杨杨. All rights reserved.
//

import UIKit

private class ListNode{
    
    public var value: Int
    public var next: ListNode?
    public init(_ value:Int){
        
        self.value = value
        self.next = nil
    }
}

private class Solution{
    
    private func getNodeValue(_ node:ListNode?) ->Int{
        //倘若元素值不为nil情况下，flapMap函数能够将可选类型(optional)转换为非可选类型(non-optionals)。
        //用在数组是降维度的，也就是会把数组合二为一
        return node.flatMap{$0.value} ?? 0
    }
    /**
     计算需要考虑的情况
     1，两个整数长度不一致
     2，进位的时候，当进位产生的时候我们需要一个标志位，以便计算下一位的和的时候，加上进位
     3，计算完后，如果还有进位，需要处理最后一位加一位的情况
    */
    func addTwoNumbers(_ l1:ListNode?,_ l2:ListNode?) -> ListNode? {
        
        //判断空值，如果为空，两个链表就无需相加执行以下的操作了
        if l1 == nil || l2 == nil {
            
            return l1 ?? l2
        }
        
        var p1 = l1
        var p2 = l2
        let result: ListNode? = ListNode(0) // 引用属性
        
        var current = result
        var extra = 0 //用于保存进位数
        
        while p1 != nil || p2 != nil || extra != 0 {
            var tot = getNodeValue(p1) + getNodeValue(p2) + extra
            
            extra = tot / 10 // 拿到进位数
            tot = tot % 10 //拿到首位数
            
            let sum:ListNode? = ListNode(tot)
            current?.next = sum // 传值给next
            current = sum // next继续成为当前的，执行下一个计算
            p1 = p1.flatMap{ $0.next }// 继续取出node的下一位，并赋值给自己，再次循环
            p2 = p2.flatMap{ $0.next }//同上
        }
        
        return result?.next
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listNode1 = ListNode(2)
        listNode1.next = ListNode(4)
        listNode1.next?.next = ListNode(1)
        
        let listNode2 = ListNode(5)
        listNode2.next = ListNode(6)
        listNode2.next?.next = ListNode(11)
        
        let sol = Solution()
        let res = sol.addTwoNumbers(listNode1, listNode2)
        
        print(res?.next ?? "")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

