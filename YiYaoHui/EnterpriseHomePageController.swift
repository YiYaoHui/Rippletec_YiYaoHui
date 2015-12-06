//
//  EnterpriseHomePageController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/5.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class EnterpriseHomePageController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleItem: UINavigationItem!
    
    var enterpriseName = ""
    var enterpriseHomePage = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleItem.title = enterpriseName

        let request = NSURLRequest(URL: NSURL(string: "http://www.jianshu.com/users/9b9d4a91a080/latest_articles")!)
        webView.loadRequest(request)
        self.view.addSubview(webView)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
    }

}
