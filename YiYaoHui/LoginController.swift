//
//  LoginController.swift
//  YiYaoHui
//
//  Created by HM on 15/12/2.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    //
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var accountTF: UITextField!
    @IBOutlet weak var cipherTF: UITextField!
    
    @IBOutlet weak var loginView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerButton.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
        accountTF.delegate = self
        cipherTF.delegate = self
        
        loginView.layer.borderWidth = 1.0
        loginView.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).CGColor
        
        tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseRegister(sender: AnyObject) {
        performSegueWithIdentifier("register", sender: self)
    }
    
    @IBAction func forgetCipher(sender: AnyObject) {
        performSegueWithIdentifier("forgetCipher", sender: self)
    }
    
    

}

//text field 的
extension LoginController : UITextFieldDelegate {
    //点击空白处收键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        accountTF.resignFirstResponder()
        cipherTF.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        accountTF.resignFirstResponder()
        cipherTF.resignFirstResponder()
        return true
    }
}
