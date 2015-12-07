//
//  ModifyCipherController.swift
//  YiYaoHui
//
//  Created by HM on 15/12/4.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class ModifyCipherController: UIViewController {
    
    @IBOutlet weak var oldCipherTF: UITextField!
    
    @IBOutlet weak var newCipherTF: UITextField!
    
    @IBOutlet weak var modifyButton: UIButton!

    @IBOutlet weak var modifyView: UIView!
    
    var oldCipher:String?
    var newCipher:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oldCipherTF.delegate = self
        newCipherTF.delegate = self

        modifyView.layer.borderWidth = 1.0
        modifyView.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).CGColor
        
        modifyButton.layer.cornerRadius = 5

    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        //去掉箭头右边文字
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), forBarMetrics: .Default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}

//text field 的
extension ModifyCipherController : UITextFieldDelegate {
    //点击空白处收键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        oldCipherTF.resignFirstResponder()
        newCipherTF.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        oldCipherTF.resignFirstResponder()
        newCipherTF.resignFirstResponder()
        return true
    }
    
    //接收原密码、新密码的text
    func textFieldDidBeginEditing(textField: UITextField) {
         oldCipher = oldCipherTF.text
        newCipher = newCipherTF.text
    }

    
}