//
//  EnterpriseCollectionController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/1.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class EnterpriseCollectionController: UIViewController {
    
    
    @IBOutlet weak var enterpriseTableView: UITableView!
    
    let index = 4

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        enterpriseTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("currentIndex", object: nil, userInfo: ["index": index])
    }

}

extension EnterpriseCollectionController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("enterpriseCell", forIndexPath: indexPath)
        cell.textLabel?.text = "安徽医药有限公司(安徽制药)"
        return cell
    }
}

extension EnterpriseCollectionController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
}
