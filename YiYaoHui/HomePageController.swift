//
//  HomePageController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/11/29.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire


class HomePageController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
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

extension HomePageController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("headerCell", forIndexPath: indexPath)
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCellWithIdentifier("meetingCell", forIndexPath: indexPath)
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("optionCell", forIndexPath: indexPath) as! OptionCell
            if indexPath.section == 2 {
                cell.optionImageView.image = UIImage(named: "video")
                cell.optionLabel.text = "医药视频"
            }
            return cell
        }
    }
    
}

extension HomePageController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                return 40
            default:
                return 97
            }
        }
        return 44
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 0 {
        
            performSegueWithIdentifier("lastestMeeting", sender: self)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.section == 0 && indexPath.row == 0 {
//            return
//        }
//        
//        cell.layer.shadowColor = UIColor.blackColor().CGColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
//        cell.layer.shadowOpacity = 0.5
//        cell.clipsToBounds = true
//    }
}
