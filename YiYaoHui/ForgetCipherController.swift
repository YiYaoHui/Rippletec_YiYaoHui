//
//  ForgetCipherController.swift
//  YiYaoHui
//
//  Created by HM on 15/12/5.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class ForgetCipherController: UIViewController {

    @IBOutlet weak var phoneNumTF: UITextField!
    
    @IBOutlet weak var verifyTF: UITextField!
    
    @IBOutlet weak var getVerifyCodeButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var getCodeButton: UIButton!
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumTF.delegate = self
        verifyTF.delegate = self
        // Do any additional setup after loading the view.
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).CGColor
        
        nextButton.layer.cornerRadius = 5
        getCodeButton.layer.cornerRadius = 3
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.title = "忘记密码"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next(sender: AnyObject) {
        performSegueWithIdentifier("resetCipher", sender: self)
    }
}

//text field 的
extension ForgetCipherController : UITextFieldDelegate {
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
