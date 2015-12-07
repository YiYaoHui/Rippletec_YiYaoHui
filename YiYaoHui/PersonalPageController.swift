//
//  PersonalPageController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/11/30.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit
import Alamofire

class PersonalPageController: UIViewController, LoginDelegate ,UIAlertViewDelegate{

    @IBOutlet weak var avatorImageView: UIImageView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var personalTableView: UITableView!
    
    @IBOutlet weak var settingButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var isLogin: Bool!
    
    //上传头像地址
    let avatorImageURL = "http://112.74.131.194:8080/MedicineProject/upload/image/portrait"
    let homeDirectory = NSHomeDirectory()
    var filePath = ""
    
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
        
        print("初始登陆状态",isLogin)
        
        setUpUI()
        
        //头像本地存储地址
        let fileUrl = NSURL(string: homeDirectory)!.URLByAppendingPathComponent("/Documents/avator.png")
        filePath = "\(fileUrl)"
        
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
            
            avatorImageView.image = UIImage(named: "avator")

        }
        else {
            loginButton.hidden = true
            
            if let image = UIImage(contentsOfFile: filePath) {
                avatorImageView.image = image
            }
            else {
                avatorImageView.image = UIImage(named: "avator")
            }

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
        loginButton.hidden = true
        self.personalTableView.reloadData()
        UIView.animateWithDuration(0.2) { () -> Void in
            self.settingButton.layer.opacity = 1.0
            self.nameLabel.layer.opacity = 1.0
        }
        tabBarController?.tabBar.hidden = false
        
        if let image = UIImage(contentsOfFile: filePath) {
            avatorImageView.image = image
        }
        else {
            avatorImageView.image = UIImage(named: "avator")
        }

        
    }

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
            
        } else if indexPath.section == 1 {
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
        } else if indexPath.section == 2 {
            cell.typeImageView.image = UIImage(named: "exit")
            cell.typeLabel.text = "退出登录"
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
            
            isLogin = NSUserDefaults.standardUserDefaults().boolForKey("loginState")
            
            if isLogin == true {
                performSegueWithIdentifier("showCollection", sender: self)
            } else {
                let alert = UIAlertController(title: "您尚未登陆", message: "无法查看收藏", preferredStyle: .Alert)
                let saveAction = UIAlertAction(title: "登陆", style: .Default) { (action:UIAlertAction) -> Void in
                    self.performSegueWithIdentifier("login", sender:self)
                }
                let cancelAction = UIAlertAction(title: "取消", style: .Default) { (action:UIAlertAction) -> Void in
                    //弹出框按了“取消”，然后取消操作为空即可。
                }
                alert.addAction(saveAction)
                alert.addAction(cancelAction)
                presentViewController(alert, animated: true, completion: nil)
            }
            
        } else if indexPath.section == 1 && indexPath.row == 0 {
            performSegueWithIdentifier("aboutUS", sender: self)
            
        } else if indexPath.section == 1 && indexPath.row == 1 {
            
            //创建分享参数
            let shareParames = NSMutableDictionary()
            
            shareParames.SSDKSetupShareParamsByText("医药信息中间平台，连接医生药企，去除中间环节，让他们能够通过平台传递直接的价值",
                images : UIImage(named:"logo"),
                url : NSURL(string:"http://112.74.131.194:8080/MedicineProject/SharePage/shareApp.html"),
                title : "医药汇",
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
                //登陆按钮要出现
                self.loginButton.hidden = false
                
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "loginState")
                //同步登陆状态
                NSUserDefaults.standardUserDefaults().synchronize()
                self.personalTableView.reloadData()
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
        
        //未登陆不能点击头像
        isLogin = NSUserDefaults.standardUserDefaults().boolForKey("loginState")
        
        if isLogin == false {
            //不能点击头像，操作为空即可。
        } else {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            
            
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
            let albumAction = UIAlertAction(title: "从相册获取", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            //MARK: waitting to do
            
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        
            let cameraAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        
            let cancleAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        
            actionSheet.addAction(albumAction)
            actionSheet.addAction(cameraAction)
            actionSheet.addAction(cancleAction)
        
            self.presentViewController(actionSheet, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
       
        let avatorImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        avatorImageView.image = avatorImage
        
        uploadAvator(avatorImage)
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Upload user's avator
    func uploadAvator(avator: UIImage) {
        saveAvator(avator)
        
        //我就这里没有session id
        let headers = ["Content-Type": "multipart/form-data"]
        
        let fileURL = NSURL(fileURLWithPath: filePath)
        
        Alamofire.upload(
            .POST,avatorImageURL,
            headers: headers,
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(fileURL: fileURL, name: "img")
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
//                        print(response)
                        print("上传头像成功")
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                    print("上传头像失败")
                }
        })
    }
    
    func saveAvator(avator: UIImage) {
        UIImagePNGRepresentation(avator)!.writeToFile(filePath, atomically: true)
    }

    
}

