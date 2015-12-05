//
//  MedicinePageController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/11/30.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class MedicinePageController: UIViewController {
    
    
    @IBOutlet weak var foregibButton: UIButton!
    @IBOutlet weak var chineseButton: UIButton!
    @IBOutlet weak var separateView: UIView!
    
    var pageController: UIPageViewController!
    var mordenMedicineController: MedicineListController!
    var tradictionMedicineController: MedicineListController!
    
    var currentPage = 1 {
        didSet {
            changeButtonColor()
            
            let sliderImageView = self.view.viewWithTag(201) as! UIImageView
            UIView.animateWithDuration(0.2) { () -> Void in
                sliderImageView.frame.origin.x = CGFloat(self.currentPage - 1) * self.view.frame.width / 2 + 15
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pageChanged:", name: "MedicineControllerAppear", object: nil)
    }
    
    func setupUI() {
        chineseButton.setTitleColor(UIColor(red: 153.0 / 255, green: 153.0 / 255, blue: 153.0 / 255, alpha: 1.0), forState: UIControlState.Normal)
        
        pageController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        pageController.dataSource = self
        
        mordenMedicineController = storyboard?.instantiateViewControllerWithIdentifier("MedicineListController") as! MedicineListController
        mordenMedicineController.medicineType = "西药"
        
        tradictionMedicineController = storyboard?.instantiateViewControllerWithIdentifier("MedicineListController") as! MedicineListController
        tradictionMedicineController.medicineType = "中药"
        
        pageController.setViewControllers([mordenMedicineController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        self.addChildViewController(pageController)
        pageController.view.frame = CGRect(x: 0, y: 105, width: self.view.frame.width, height: self.view.frame.height - 149.0)
        self.view.addSubview(pageController.view)
        
        let sliderImageView = UIImageView(frame: CGRect(x: 15, y: -1.5, width: self.view.frame.width / 2.0 - 30.0, height: 2))
        sliderImageView.tag = 201
        sliderImageView.image = UIImage(named: "slider")
        separateView.addSubview(sliderImageView)
    }
    
    
    @IBAction func chooseMedicineType(sender: UIButton) {
        currentPage = sender.tag - 100
    }
    
    func changeButtonColor() {
        foregibButton.setTitleColor(UIColor(red: 150.0 / 255.0, green: 118.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0), forState: UIControlState.Normal)
        chineseButton.setTitleColor(UIColor(red: 153.0 / 255, green: 153.0 / 255, blue: 153.0 / 255, alpha: 1.0), forState: UIControlState.Normal)
        
        switch currentPage {
        case 1:
            pageController.setViewControllers([mordenMedicineController], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
            foregibButton.setTitleColor(UIColor(red: 150.0 / 255.0, green: 118.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0), forState: UIControlState.Normal)
            chineseButton.setTitleColor(UIColor(red: 153.0 / 255, green: 153.0 / 255, blue: 153.0 / 255, alpha: 1.0), forState: UIControlState.Normal)
        default:
            chineseButton.setTitleColor(UIColor(red: 150.0 / 255.0, green: 118.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0), forState: UIControlState.Normal)
            foregibButton.setTitleColor(UIColor(red: 153.0 / 255, green: 153.0 / 255, blue: 153.0 / 255, alpha: 1.0), forState: UIControlState.Normal)
            pageController.setViewControllers([tradictionMedicineController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
    }
    
    func pageChanged(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let medicineType = userInfo["medicineType"] as! String
        if medicineType == "西药" {
            currentPage = 1
        }
        else {
            currentPage = 2
        }
    }

}

extension MedicinePageController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentPage = viewController as! MedicineListController
        if currentPage.medicineType == "中药" {
            return mordenMedicineController
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentPage = viewController as! MedicineListController
        if currentPage.medicineType == "西药" {
            return tradictionMedicineController
        }
        return nil
    }

}

