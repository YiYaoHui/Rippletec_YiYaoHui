//
//  AboutUsController.swift
//  YiYaoHui
//
//  Created by HM on 15/12/5.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class AboutUsController: UIViewController {
    //
    @IBOutlet weak var iconView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconView.layer.cornerRadius = 5
        iconView.clipsToBounds = true
        
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
