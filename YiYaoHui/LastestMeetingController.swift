//
//  LastestMeetingController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/1.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit
import Alamofire

class LastestMeetingController: UIViewController {
    
    
    @IBOutlet weak var meetingTableView: UITableView!
    
    let baseURL = "http://112.74.131.194:8080/MedicineProject/App/res/getRecentMeeting"
    
    var meetings = [Meeting]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "最新会议"
        
        meetingTableView.registerNib(UINib(nibName: "MeetingCell", bundle: nil), forCellReuseIdentifier: "meetingCell")
        meetingTableView.tableFooterView = UIView(frame: CGRectZero)
        
        getMeetingsData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func getMeetingsData() {
        Alamofire.request(.POST, baseURL, parameters: ["size": 100], encoding: ParameterEncoding.URL, headers: nil).responseJSON { (_, _, result) -> Void in
            
            if let value = result.value {
                
                if let Meetings = value["Meetings"] as? [Dictionary<String, AnyObject>] {
                    for item in Meetings {
                        let meeting = Meeting(meeting: item)
                        self.meetings.append(meeting)
                    }
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.meetingTableView.reloadData()
                })
            }
            else {
            
                //MARK: something error
            }
        }
    }

}

extension LastestMeetingController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let meeting = meetings[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("meetingCell", forIndexPath: indexPath) as! MeetingCell
        cell.titleLabel.text = meeting.name
        cell.holderLabel.text = meeting.enterpriseName
        cell.timeLabel.text = meeting.commitDate
        return cell
    }

}

extension LastestMeetingController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
