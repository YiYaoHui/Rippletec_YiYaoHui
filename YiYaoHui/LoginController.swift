//
//  LoginController.swift
//  YiYaoHui
//
//  Created by HM on 15/12/2.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit
import Alamofire

protocol LoginDelegate {
    func loginSuccess()
}

class LoginController: UIViewController {
    //
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var accountTF: UITextField!
    @IBOutlet weak var cipherTF: UITextField!
    
    @IBOutlet weak var loginView: UIView!
    
    var delegate: LoginDelegate!
    
    let baseURL = "http://112.74.131.194:8080/MedicineProject/App/login"
    let personalController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("personalController")

    var account:String?
    var cipher:String?
    var identifierForVendor:String?
    
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
    
    //登陆请求
    @IBAction func login(sender: AnyObject) {

        identifierForVendor = UIDevice.currentDevice().identifierForVendor?.UUIDString
        
        Alamofire.request(.POST, baseURL, parameters: ["account":account!,"password":cipher!,"device":"2","deviceId":identifierForVendor!], encoding: .URL, headers: nil).responseJSON { (_, _, result) -> Void in
            if let value = result.value {
                
                //随时保存登陆状态，同步到ns user defaults: 登陆成功的话，bool设成true。
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loginState")
                NSUserDefaults.standardUserDefaults().synchronize()
                self.delegate.loginSuccess()
                NSUserDefaults.standardUserDefaults().setValue(self.account, forKey: "account")
                NSUserDefaults.standardUserDefaults().setValue(self.cipher, forKey: "cipher")
                
                print("登陆",result)
                self.navigationController?.pushViewController(self.personalController, animated: true)
            }
        }
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        account = accountTF.text
        cipher = cipherTF.text
    }
}
