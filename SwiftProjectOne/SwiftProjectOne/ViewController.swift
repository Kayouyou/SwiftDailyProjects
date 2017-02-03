//
//  ViewController.swift
//  SwiftProjectOne
//
//  Created by 叶杨杨 on 2017/2/3.
//  Copyright © 2017年 叶杨杨. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var timeLable: UILabel!
    
    @IBOutlet weak var singleButton: UIButton!
    var Counter = 0.0
    private lazy var CountDownTimer: Timer = {
        
        let timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        return timer
    }()
    var IsPlaying = false
    //swift3.0 基于某一个控制器修改状态栏的颜色，重写这个属性既可以！
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get {
            return.lightContent
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        timeLable.text = String(Counter);
    }

    //销毁计时器
    override func viewWillDisappear(_ animated: Bool) {
     super.viewWillDisappear(animated)
        CountDownTimer.invalidate()
    }
    
    @IBAction func startTap(_ sender: UIButton) {
    
        if IsPlaying {
            return
        }
        startButton.isEnabled = false
        endButton.isEnabled   = true
        CountDownTimer.reuseTimer()
        IsPlaying = true
    }
    
    @IBAction func endOrPauseTap(_ sender: Any) {
        
        startButton.isEnabled = true
        endButton.isEnabled   = false
        CountDownTimer.pasuseTimer()
        IsPlaying = false
    }
    
    @IBAction func resetTap(_ sender: Any) {
        IsPlaying = false;
        Counter = 0
        timeLable.text = String(Counter)
        startButton.isEnabled = true;
        endButton.isEnabled   = true;
    }
    
    @objc func updateTimer() ->() {
        
        Counter = Counter + 0.1
        timeLable.text = String(format:"%.1f",Counter)
    }

    @IBAction func singleTap(_ sender: UIButton) {
    
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            
            CountDownTimer.reuseTimer()
            sender.titleLabel?.text = "开始";
        }else{
            
            CountDownTimer.pasuseTimer()
            sender.titleLabel?.text = "暂停"
        }
    }
}

// MARK:控制器扩展

extension ViewController{
    

}



