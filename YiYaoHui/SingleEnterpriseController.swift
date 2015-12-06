//
//  SingleEnterpriseController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/4.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices

class SingleEnterpriseController: UIViewController {
    
    @IBOutlet weak var enterpriseLogoView: UIImageView!
    @IBOutlet weak var enterpriseNameLabel: UILabel!
    @IBOutlet weak var enterpriseHomePageButton: UIButton!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var titleItem: UINavigationItem!
    
    
    var isExpand = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterpriseNameLabel.text = "波纹制药有限公司"
        titleItem.title = "波纹制药有限公司"

        optionsTableView.tableFooterView = UIView(frame: CGRectZero)
        enterpriseHomePageButton.layer.cornerRadius = 7
        enterpriseHomePageButton.clipsToBounds = true
        
        enterpriseLogoView.layer.borderColor = UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153 / 255.0, alpha: 1).CGColor
        enterpriseLogoView.layer.borderWidth = 0.5
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    @IBAction func viewEnterpriseHomePage(sender: UIButton) {
        self.hidesBottomBarWhenPushed = true
        performSegueWithIdentifier("toHomePage", sender: self)
        self.hidesBottomBarWhenPushed = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! EnterpriseHomePageController
        destinationVC.enterpriseName = "波纹制药有限公司"
    }

}

extension SingleEnterpriseController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        return isExpand == true ? 3 : 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("optionCell", forIndexPath: indexPath) as! OptionCell
            switch indexPath.row {
            case 0:
                cell.optionImageView.image = UIImage(named: "medicine_red")
                cell.optionLabel.text = "药品"
                cell.rightImageView.image = UIImage(named: "rightArrow")
                return cell
            case 1:
                cell.optionImageView.image = UIImage(named: "video")
                cell.optionLabel.text = "医药视频"
                cell.rightImageView.image = UIImage(named: "rightArrow")
                return cell
            default:
                cell.optionImageView.image = UIImage(named: "meeting")
                cell.optionLabel.text = "会议视频"
                cell.rightImageView.image = UIImage(named: "rightArrow")
                return cell
            }
        }
        else {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("optionCell", forIndexPath: indexPath) as! OptionCell
                cell.optionImageView.image = UIImage(named: "consult")
                cell.optionLabel.text = "咨询方式"
                if isExpand == true {
                    cell.rightImageView.image = UIImage(named: "upArrow")
                }
                else {
                    cell.rightImageView.image = UIImage(named: "downArrow")
                }
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("consultCell", forIndexPath: indexPath)
                let wayLabel = cell.viewWithTag(201) as! UILabel
                wayLabel.text = "热线:"
                let contentLabel = cell.viewWithTag(202) as! UILabel
                contentLabel.text = "18813756456"
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("consultCell", forIndexPath: indexPath)
                let wayLabel = cell.viewWithTag(201) as! UILabel
                wayLabel.text = "邮箱:"
                let contentLabel = cell.viewWithTag(202) as! UILabel
                contentLabel.text = "18813756456@163.com"
                return cell
            }
        }
    }
}

extension SingleEnterpriseController: UITableViewDelegate, MFMailComposeViewControllerDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                isExpand = !isExpand
                tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Automatic)
            case 1:
                let webView = UIWebView()
                webView.frame = CGRectZero
                let callString = "tel:661282"
                webView.loadRequest(NSURLRequest(URL: NSURL(string: callString)!))
                self.view.addSubview(webView)
            default:
                let mailController = MFMailComposeViewController()
                mailController.mailComposeDelegate = self
                mailController.setToRecipients(["452051211@qq.com"])
                mailController.setSubject("问题咨询")
                
                self.presentViewController(mailController, animated: true, completion: nil)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
}

