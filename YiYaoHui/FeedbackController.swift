//
//  FeedbackController.swift
//  YiYaoHui
//
//  Created by HM on 15/12/2.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class FeedbackController: UIViewController {
//
     @IBOutlet weak var SuggestionTextView: UITextView!
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var qqTF: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var textFieldView: UIView!
    

    var currentSuggestion: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SuggestionTextView.delegate = self
        phoneNumTF.delegate = self
        qqTF.delegate = self
        
        sendButton.layer.cornerRadius = 5.0
        
        textFieldView.layer.borderWidth = 1.0
        textFieldView.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).CGColor
        
        navigationController?.navigationBarHidden = false
        
        SuggestionTextView.text = "请填写您的宝贵意见："
        //使textview不受navigation bar影响，可以使内容置顶显示。
        self.automaticallyAdjustsScrollViewInsets = false
        SuggestionTextView.layer.borderWidth = 1.0
        SuggestionTextView.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension FeedbackController: UITextViewDelegate , UITextFieldDelegate {
    
    //textview的
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        SuggestionTextView.resignFirstResponder()
        return true
    }
    //点击空白处收键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        SuggestionTextView.resignFirstResponder()
        //如果什么也没输入，就显示hint
        if SuggestionTextView.text == "" {
            SuggestionTextView.text = "请填写您的宝贵意见："
        }
    }
    //清除hint ; 断点输入。
    func textViewDidBeginEditing(textView: UITextView) {
        if SuggestionTextView.text == "请填写您的宝贵意见：" {
            SuggestionTextView.text = ""
        } else {
            currentSuggestion = SuggestionTextView.text
        }
    }
    
    //text field 的
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        phoneNumTF.resignFirstResponder()
        qqTF.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        phoneNumTF.resignFirstResponder()
        qqTF.resignFirstResponder()
        return true
    }
    
}
