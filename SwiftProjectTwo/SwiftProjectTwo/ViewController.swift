//
//  ViewController.swift
//  SwiftProjectTwo
//
//  Created by 叶杨杨 on 2017/2/6.
//  Copyright © 2017年 叶杨杨. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    

    var data = ["30 Days Swift", "这些字体特别适合打「奋斗」和「理想」", "谢谢「造字工房」，本案例不涉及商业使用", "使用到造字工房劲黑体，致黑体，童心体", "呵呵，再见🤗 See you next Project"]
    
    var fontNames = ["MFTongXin_Noncommercial-Regular", "MFJinHei_Noncommercial-Regular", "MFZhiHei_Noncommercial-Regular", "edundot", "Gaspar Regular"]
    var fontRowIndex = 0
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        for family in UIFont.familyNames {
            
            for font  in UIFont.fontNames(forFamilyName: family){
                
                print(font)
            }
        }
        
        changeButton.layer.cornerRadius = 5.0
    }

    // MARK: 改变字体按钮
    @IBAction func changeFontTap(_ sender: Any) {
    
        fontRowIndex = (fontRowIndex + 1) % 5
        print(fontNames[fontRowIndex])
        tableView.reloadData()
    }
    
    // MARK: tableview 代理
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fontCell", for: indexPath)
        let text = data[indexPath.row]
        cell.textLabel?.text = text
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: self.fontNames[fontRowIndex], size: 15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

}

