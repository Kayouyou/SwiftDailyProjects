//
//  Timer-Extension.swift
//  SwiftProjectOne
//
//  Created by 叶杨杨 on 2017/2/3.
//  Copyright © 2017年 叶杨杨. All rights reserved.
//

import Foundation

extension Timer{
    
    //暂停计时器
    func pasuseTimer() -> () {
        
        self.fireDate = NSDate.distantFuture
    }
    //重启计时器
    func reuseTimer() -> () {
        
        self.fireDate = NSDate.distantPast
    }

}
