//
//  EnterprisePageController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/11/30.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class EnterprisePageController: UIViewController {
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var foreginButton: UIButton!
    @IBOutlet weak var cooperateButton: UIButton!
    @IBOutlet weak var innerButton: UIButton!
    
    var buttons = [UIButton]()
    
    var pageController: UIPageViewController!
    var foreginController: EnterpriseListController!
    var cooperateController: EnterpriseListController!
    var innerController: EnterpriseListController!
    
    var currentPage = 1 {
        didSet {
            changeButtonColor()
            
            let sliderImageView = self.view.viewWithTag(201) as! UIImageView
            UIView.animateWithDuration(0.2) { () -> Void in
                sliderImageView.frame.origin.x = CGFloat(self.currentPage - 1) * self.view.frame.width / 3 + 8
            }
        }
    }
    
    var lastPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //title = "企业"
        
        pageController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        pageController.dataSource = self
        
        foreginController = storyboard?.instantiateViewControllerWithIdentifier("EnterpriseListController") as! EnterpriseListController
        foreginController.enterpriseType = "1"
        foreginController.index = 1
        
        cooperateController = storyboard?.instantiateViewControllerWithIdentifier("EnterpriseListController") as! EnterpriseListController
        cooperateController.enterpriseType = "2"
        cooperateController.index = 2
        
        innerController = storyboard?.instantiateViewControllerWithIdentifier("EnterpriseListController") as! EnterpriseListController
        innerController.enterpriseType = "0"
        innerController.index = 3
        
        pageController.setViewControllers([foreginController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        self.addChildViewController(pageController)
        pageController.view.frame = CGRect(x: 0, y: 105, width: self.view.frame.width, height: self.view.frame.height - 149.0)
        self.view.addSubview(pageController.view)
        
        let sliderImageView = UIImageView(frame: CGRect(x: 8, y: -1.5, width: self.view.frame.width / 3.0 - 16.0, height: 2))
        sliderImageView.tag = 201
        sliderImageView.image = UIImage(named: "slider")
        separateView.addSubview(sliderImageView)
        
        buttons.append(foreginButton)
        buttons.append(cooperateButton)
        buttons.append(innerButton)
        
        changeButtonColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pageChanged:", name: "viewDidAppear", object: nil)
    }
    
    func pageChanged(notification: NSNotification) {
        let userInfo = notification.userInfo
        let index = userInfo!["index"] as! Int
        currentPage = index
    }

    func changeButtonColor() {
        for button in buttons {
            button.setTitleColor(UIColor(red: 153.0 / 255, green: 153.0 / 255, blue: 153.0 / 255, alpha: 1.0), forState: UIControlState.Normal)
            if button.tag - 100 == currentPage {
                button.setTitleColor(UIColor(red: 150.0 / 255.0, green: 118.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0), forState: UIControlState.Normal)
            }
        }
    }
    
    @IBAction func chooseEnterpriseType(sender: UIButton) {
        currentPage = sender.tag - 100
        if currentPage > lastPage {
            if currentPage == 2 {
                pageController.setViewControllers([cooperateController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            }
            else {
                pageController.setViewControllers([innerController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            }
        }
        else {
            if currentPage == 1 {
                pageController.setViewControllers([foreginController], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
            }
            else {
                pageController.setViewControllers([cooperateController], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
            }
        }
        lastPage = currentPage
    }
    
    
}

extension EnterprisePageController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentPage = viewController as! EnterpriseListController
        
        switch currentPage.index {
        case 1:
            return nil
        case 2:
            return foreginController
        default:
            return cooperateController
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentPage = viewController as! EnterpriseListController
        
        switch currentPage.index {
        case 1:
            return cooperateController
        case 2:
            return innerController
        default:
            return nil
        }

    }
    
}




