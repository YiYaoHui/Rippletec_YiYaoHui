//
//  CollectionController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/1.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class CollectionController: UIViewController {
    
    @IBOutlet weak var medicineButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var meetingButton: UIButton!
    @IBOutlet weak var enterpriseButton: UIButton!
    @IBOutlet weak var separateView: UIView!
    
    
    var pageController: UIPageViewController!
    var medicineCollectionController: MedicineCollectionController!
    var videoCollectionController: VideoCollectionController!
    var meetingCollectionController: MeetingCollectionController!
    var enterpriseCollectionController: EnterpriseCollectionController!
    
    var currentPage = 1 {
        didSet {
            changeButtonColor()
            
            let sliderImageView = self.view.viewWithTag(201) as! UIImageView
            UIView.animateWithDuration(0.2) { () -> Void in
                sliderImageView.frame.origin.x = CGFloat(self.currentPage - 1) * self.view.frame.width / 4 + 8
            }
        }
    }
    var lastPage = 1
    
    var controllers = [UIViewController]()
    var buttons = [UIButton]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        pageController.dataSource = self
        
        medicineCollectionController = storyboard?.instantiateViewControllerWithIdentifier("MedicineCollectionController") as! MedicineCollectionController
        videoCollectionController = storyboard?.instantiateViewControllerWithIdentifier("VideoCollectionController") as! VideoCollectionController
        meetingCollectionController = storyboard?.instantiateViewControllerWithIdentifier("MeetingCollectionController") as! MeetingCollectionController
        enterpriseCollectionController = storyboard?.instantiateViewControllerWithIdentifier("EnterpriseCollectionController") as! EnterpriseCollectionController
        
        pageController.setViewControllers([medicineCollectionController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.addChildViewController(pageController)
        pageController.view.frame = CGRect(x: 0, y: 105, width: self.view.frame.width, height: self.view.frame.height - 149)
        self.view.addSubview(pageController.view)
        
        controllers.append(UIViewController())
        controllers.append(medicineCollectionController)
        controllers.append(videoCollectionController)
        controllers.append(meetingCollectionController)
        controllers.append(enterpriseCollectionController)
        
        buttons.append(medicineButton)
        buttons.append(videoButton)
        buttons.append(meetingButton)
        buttons.append(enterpriseButton)
        
        let sliderImageView = UIImageView(frame: CGRect(x: 8, y: -1.5, width: self.view.frame.width / 4.0 - 16.0, height: 2))
        sliderImageView.tag = 201
        sliderImageView.image = UIImage(named: "slider")
        separateView.addSubview(sliderImageView)
        
        changeButtonColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pageChanged:", name: "currentIndex", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBarHidden = true
    }
    
    func pageChanged(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: Int]
        currentPage = userInfo["index"]!
    }
    
    @IBAction func changeCollectionType(sender: UIButton) {
        currentPage = sender.tag - 100
        if currentPage > lastPage {
            pageController.setViewControllers([controllers[currentPage]], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
        else {
            pageController.setViewControllers([controllers[currentPage]], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
        }
        lastPage = currentPage
    }
    
    func changeButtonColor() {
        for button in buttons {
            button.setTitleColor(UIColor(red: 153.0 / 255, green: 153.0 / 255, blue: 153.0 / 255, alpha: 1.0), forState: UIControlState.Normal)
            if button.tag - 100 == currentPage {
                button.setTitleColor(UIColor(red: 150.0 / 255.0, green: 118.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0), forState: UIControlState.Normal)
            }
        }
    }
    
}

extension CollectionController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if currentPage == 1 {
            return nil
        }
        return controllers[currentPage - 1]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if currentPage == 4 {
            return nil
        }
        return controllers[currentPage + 1]
    }
}
