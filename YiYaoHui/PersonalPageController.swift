//
//  PersonalPageController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/11/30.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class PersonalPageController: UIViewController {


    @IBOutlet weak var avatorImageView: UIImageView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var personalTableView: UITableView!
    
    @IBOutlet weak var settingButton: UIButton!
    
    //为了可以合到master上，我减去了这么一句注释。。。
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)

        settingButton.layer.cornerRadius = 12.5
        settingButton.layer.borderColor = UIColor.whiteColor().CGColor
        settingButton.layer.borderWidth = 1.0
        
        loginButton.layer.cornerRadius = 15.0
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        loginButton.layer.borderWidth = 1.0
        
        avatorImageView.layer.cornerRadius = 40
        avatorImageView.clipsToBounds = true
        
        personalTableView.tableFooterView = UIView(frame: CGRectZero)
        
        navigationController?.navigationBarHidden = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func login(sender: AnyObject) {
        performSegueWithIdentifier("login", sender: self)
    }
    
    @IBAction func setting(sender: AnyObject) {
        performSegueWithIdentifier("setting", sender: self)
    }
    
    
}

extension PersonalPageController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 3
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("personalCell", forIndexPath: indexPath) as! PersonalCell
        
        if indexPath.section == 0 {
            
        }
        else {
            switch indexPath.row {
            case 0:
                cell.typeImageView.image = UIImage(named: "about")
                cell.typeLabel.text = "关于我们"
            case 1:
                cell.typeImageView.image = UIImage(named: "share")
                cell.typeLabel.text = "分享给朋友"
            default:
                cell.typeImageView.image = UIImage(named: "feedback")
                cell.typeLabel.text = "意见反馈"
            }
        }
        return cell
    }

}

extension PersonalPageController: UITableViewDelegate {

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            performSegueWithIdentifier("showCollection", sender: self)
            
        } else if indexPath.section == 1 && indexPath.row == 0 {
            performSegueWithIdentifier("aboutUS", sender: self)
            
        } else if indexPath.section == 1 && indexPath.row == 1 {
            
            //创建分享参数
            let shareParames = NSMutableDictionary()
            
            shareParames.SSDKSetupShareParamsByText("分享内容",
                images : UIImage(named: "shareImg.png"),
                url : NSURL(string:"http://mob.com"),
                title : "分享标题",
                type : SSDKContentType.Auto)
            //2.进行分享 ，添加了多少个进白名单，弹框就有多少个。
            ShareSDK.showShareActionSheet(self.view, items:nil, shareParams: shareParames) { (state : SSDKResponseState, platformType : SSDKPlatformType, userdata : [NSObject : AnyObject]!, contentEnity : SSDKContentEntity!, error : NSError!, Bool end) -> Void in
            
                switch state{
                    
                case SSDKResponseState.Success: print("分享成功")
                    let alert = UIAlertView(title: "分享成功", message: "分享成功", delegate: self, cancelButtonTitle: "取消")
                    alert.show()
                case SSDKResponseState.Fail:    print("分享失败,错误描述:\(error)")
                case SSDKResponseState.Cancel:  print("分享取消")
                    
                default:
                    break
                }
            }
        } else if indexPath.section == 1 && indexPath.row == 2 {
            
            performSegueWithIdentifier("feedback", sender: self)
            
        }

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension PersonalPageController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func changeAvator(sender: AnyObject) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let albumAction = UIAlertAction(title: "从相册获取", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            //MARK: waitting to do
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        let cameraAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        let cancleAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        
        actionSheet.addAction(albumAction)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(cancleAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        avatorImageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

