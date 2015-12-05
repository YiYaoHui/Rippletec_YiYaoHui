//
//  SettingController.swift
//  YiYaoHui
//
//  Created by HM on 15/12/4.
//  Copyright © 2015年 EgeTart. All rights reserved.
//
//
import UIKit

class SettingController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var switchButton: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).CGColor
        
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
    
    @IBAction func modify(sender: AnyObject) {
        performSegueWithIdentifier("modify", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
