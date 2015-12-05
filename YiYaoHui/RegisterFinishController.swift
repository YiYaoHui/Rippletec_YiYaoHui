//
//  RegisterFinishController.swift
//  YiYaoHui
//
//  Created by HM on 15/12/3.
//  Copyright © 2015年 EgeTart. All rights reserved.
//
//
import UIKit

class RegisterFinishController: UIViewController {
    
    @IBOutlet weak var cipherForRegisterTF: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    @IBOutlet weak var registerFinishView: UIView!
    
    //此页面与忘记密码后的置新密码页面一致。
//    var pageTitle = "注册"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.layer.cornerRadius = 5
        
        registerFinishView.layer.borderWidth = 1.0
        registerFinishView.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).CGColor
        
        confirmTF.delegate = self
        cipherForRegisterTF.delegate = self
        
        tabBarController?.tabBar.hidden = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //自定义title
        self.navigationController?.navigationBar.backItem?.title = ""
        self.title = "注册"
        
        //去掉箭头右边文字
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), forBarMetrics: .Default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//text field 的
extension RegisterFinishController : UITextFieldDelegate {
    //点击空白处收键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        cipherForRegisterTF.resignFirstResponder()
        confirmTF.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        cipherForRegisterTF.resignFirstResponder()
        confirmTF.resignFirstResponder()
        return true
    }
}

