//
//  MeetingCollectionController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/1.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class MeetingCollectionController: UIViewController {
    
    
    @IBOutlet weak var meetingTableView: UITableView!
    
    let index = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        meetingTableView.registerNib(UINib(nibName: "MeetingCell", bundle: nil), forCellReuseIdentifier: "meetingCell")
        meetingTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("currentIndex", object: nil, userInfo: ["index": index])
    }

}

extension MeetingCollectionController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("meetingCell", forIndexPath: indexPath) as! MeetingCell
        
        return cell
    }
}

extension MeetingCollectionController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

