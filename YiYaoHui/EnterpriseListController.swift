//
//  EnterpriseListController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/11/30.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class EnterpriseListController: UIViewController {
    
    
    @IBOutlet weak var enterpriseTableView: UITableView!
    
    var enterpriseType = ""
    var index = 0
    var enterprises: Enterprises!
    
    var sectionTitles = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()

        enterprises = Enterprises(enterpriseType: enterpriseType)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "completedHandler:", name: "FinishedLoad", object: nil)
        
        enterpriseTableView.sectionIndexColor = UIColor.blackColor()
        
        enterpriseTableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("viewDidAppear", object: nil, userInfo: ["index": index])
    }
    
    
    
    func completedHandler(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: String]
        let state = userInfo["result"]!
        
        if state == "success" {
            sectionTitles = enterprises.enterpriseGroup.keys.sort({ (str1, str2) -> Bool in
                return str1 < str2
            })
            enterpriseTableView.reloadData()
        }
        else {
            let alert = UIAlertController(title: "提示", message: "未建立网络连接", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }

}

extension EnterpriseListController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sectionTitles[section]
        return enterprises.enterpriseGroup[key]!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("enterpriseCell", forIndexPath: indexPath)
        let key = sectionTitles[indexPath.section]
        let enterprise = enterprises.enterpriseGroup[key]![indexPath.row]
        cell.textLabel?.text = enterprise.name
        return cell
    }

}

extension EnterpriseListController: UITableViewDelegate {

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor(red: 153.0 / 255, green: 153.0 / 255, blue: 153.0 / 255, alpha: 1.0)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.textLabel?.textColor = UIColor(red: 48.0 / 255, green: 48.0 / 255, blue: 48.0 / 255, alpha: 1.0)
        cell.textLabel?.font = UIFont(name: "Helvetical Neue", size: 18)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toEnterprise", sender: self)
    }

}
