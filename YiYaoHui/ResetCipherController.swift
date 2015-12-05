//
//  ResetCipherController.swift
//  YiYaoHui
//
//  Created by HM on 15/12/5.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class ResetCipherController: UIViewController {
    
    @IBOutlet weak var cipherForResetTF: UITextField!
    
    @IBOutlet weak var confirmTF: UITextField!
    
    @IBOutlet weak var visiableButton: UIButton!

    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cipherForResetTF.delegate = self
        confirmTF.delegate = self
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).CGColor
        
        resetButton.layer.cornerRadius = 5

    }
    //
    override func viewWillAppear(animated: Bool) {
        
        //去掉箭头右边文字
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), forBarMetrics: .Default)
        
        navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.title = "重置密码"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//text field 的
extension ResetCipherController : UITextFieldDelegate {
    //点击空白处收键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        cipherForResetTF.resignFirstResponder()
        confirmTF.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        cipherForResetTF.resignFirstResponder()
        confirmTF.resignFirstResponder()
        return true
    }
}
