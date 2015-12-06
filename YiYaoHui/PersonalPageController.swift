//
//  PersonalPageController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/11/30.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class PersonalPageController: UIViewController, LoginDelegate ,UIAlertViewDelegate{

    @IBOutlet weak var avatorImageView: UIImageView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var personalTableView: UITableView!
    
    @IBOutlet weak var settingButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var isLogin: Bool!
    
    
    lazy var backgroundView: UIView = {
        let _backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        
        _backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        return _backgroundView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        
        //记录初始登陆状态
        isLogin = NSUserDefaults.standardUserDefaults().boolForKey("loginState")
//        isLogin = false
        
        print(isLogin)
        
        setUpUI()
        
        personalTableView.registerNib(UINib(nibName: "optionCell", bundle: nil), forCellReuseIdentifier: "optionCell")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        //这样写修复了一个bug
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //跳到登陆界面
    @IBAction func login(sender: AnyObject) {
        (sender as! UIButton).hidden = true
        performSegueWithIdentifier("login", sender: self)
    }
    
    @IBAction func setting(sender: AnyObject) {
        performSegueWithIdentifier("setting", sender: self)
    }
    
    func setUpUI() {
        
        loginButton.layer.cornerRadius = 15.0
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        loginButton.layer.borderWidth = 1.0

        avatorImageView.layer.cornerRadius = 40
        avatorImageView.clipsToBounds = true
        
        personalTableView.tableFooterView = UIView(frame: CGRectZero)
        
        settingButton.layer.cornerRadius = 12.5
        settingButton.layer.borderColor = UIColor.whiteColor().CGColor
        settingButton.layer.borderWidth = 1.0
        
        if isLogin == false {
            settingButton.hidden = true
            settingButton.layer.opacity = 0.0
            
            nameLabel.hidden = true
            nameLabel.layer.opacity = 0.0
            
            loginButton.hidden = false
        }
        else {
            loginButton.hidden = true
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "login" {
            let destinationVC = segue.destinationViewController as! LoginController
            destinationVC.delegate = self
        }
    }
    
    //MARK: 对登陆成功做出响应
    func loginSuccess() {
        settingButton.hidden = false
        nameLabel.hidden = false
        self.personalTableView.reloadData()
        UIView.animateWithDuration(0.2) { () -> Void in
            self.settingButton.layer.opacity = 1.0
            self.nameLabel.layer.opacity = 1.0
        }
    }
    //MARK: 对AlertView的按钮点击做出响应
//    func alertView(button clickedButton: UIButton) {
//        
//        if clickedButton.tag == 202 {
//            loginButton.hidden = false
//            loginButton.layer.opacity = 0
//            
//            UIView.animateWithDuration(0.2, animations: { () -> Void in
//                self.loginButton.layer.opacity = 1.0
//                self.settingButton.layer.opacity = 0.0
//                self.nameLabel.layer.opacity = 0.0
//                }, completion: { (_) -> Void in
//                    self.settingButton.hidden = true
//                    self.nameLabel.hidden = true
//                    self.avatorImageView.image = UIImage(named: "avator")
//                    NSUserDefaults.standardUserDefaults().setBool(false, forKey: "loginState")
//                    self.personalTableView.reloadData()
//            })
//        }
//        
//        self.tabBarController?.tabBar.hidden = false
//        
//        clickedButton.superview?.superview?.removeFromSuperview()
//        backgroundView.hidden = true
//    }

}

extension PersonalPageController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        isLogin = NSUserDefaults.standardUserDefaults().boolForKey("loginState")
        if isLogin == true {
            return 3
        }
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default: //退出登陆的
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("personalCell", forIndexPath: indexPath) as! PersonalCell
        
        if indexPath.section == 0 {
            
        }
        
        else {
            if indexPath.section == 1 {
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
            } else {
                cell.typeImageView.image = UIImage(named: "exit")
                cell.typeLabel.text = "退出登录"
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
            
        } else if indexPath.section == 2 {
            
            
            let alert = UIAlertController(title: "提示", message: "确定退出吗？", preferredStyle: .Alert)
        
            let saveAction = UIAlertAction(title: "确定", style: .Default) { (action:UIAlertAction) -> Void in

                self.settingButton.hidden = true
                self.nameLabel.hidden = true
                self.avatorImageView.image = UIImage(named: "avator")
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "loginState")
            }
        
            let cancelAction = UIAlertAction(title: "取消", style: .Default) { (action:UIAlertAction) -> Void in
                //弹出框按了“取消”，然后取消操作为空即可。
            }
        
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            presentViewController(alert, animated: true, completion: nil)
        }
            
        else if indexPath.section == 1 && indexPath.row == 2 {
            self.performSegueWithIdentifier("feedback", sender: self)
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

