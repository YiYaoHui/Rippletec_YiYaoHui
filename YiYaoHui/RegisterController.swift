//
//  RegisterController.swift
//  YiYaoHui
//
//  Created by HM on 15/12/3.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    @IBOutlet weak var nextStepButton: UIButton!
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var verifyTF: UITextField!
    @IBOutlet weak var getVerifyCodeButton: UIButton!

    @IBOutlet weak var registerView: UIView!
    
//    //初始化本页面的title
//    var pageTitle = "获取验证码"
    //

    override func viewDidLoad() {
        super.viewDidLoad()

        phoneNumTF.delegate = self
        verifyTF.delegate = self
        nextStepButton.layer.cornerRadius = 5
        getVerifyCodeButton.layer.cornerRadius = 3
        
        registerView.layer.borderWidth = 1.0
        registerView.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).CGColor
        
        tabBarController?.tabBar.hidden = true
        
        
    }

    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        
        //重用controller时传过来的参数。
//        self.title = pageTitle
        
        self.navigationController?.navigationBar.backItem?.title = ""
        self.title = "获取验证码"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nextStep(sender: AnyObject) {
        performSegueWithIdentifier("finishRegister", sender: self)
    }
}

//text field 的
extension RegisterController : UITextFieldDelegate {
    //点击空白处收键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        phoneNumTF.resignFirstResponder()
        verifyTF.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        phoneNumTF.resignFirstResponder()
        verifyTF.resignFirstResponder()
        return true
    }
}
