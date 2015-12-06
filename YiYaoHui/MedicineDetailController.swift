//
//  MedicineDetailController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/3.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class MedicineDetailController: UIViewController {

    
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var titleItem: UINavigationItem!
    
    var medicineType = ""
    var medicineID = ""
    var medicineName = ""
    
    let db = MedicineDB.sharedInstance()
    
    var titles = [String]()
    var contents = [String]()
    
    var menuIsShow = false
    
    lazy var optionsTableView: UIView! = {
        let tableView: UITableView = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: 135.0, height: CGFloat(44 * 8)))
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorStyle = .None
        tableView.tag = 501
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "optionCell")
        let containerView: UIView = UIView(frame: CGRect(x: self.view.frame.width + 5, y: 0, width: 135.0, height: CGFloat(44 * 8)))
        containerView.center.y = self.view.center.y + 32
        containerView.layer.shadowColor = UIColor.blackColor().CGColor
        containerView.layer.shadowOffset = CGSize(width: -4, height: 4)
        containerView.layer.shadowOpacity = 0.5
        containerView.clipsToBounds = false
        containerView.layer.cornerRadius = 10
        containerView.addSubview(tableView)
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTableView.tableFooterView = UIView(frame: CGRectZero)
        detailTableView.estimatedRowHeight = 50
        detailTableView.rowHeight = UITableViewAutomaticDimension
        
        if medicineType == "西药" {
            getDataFromWestMedicines()
        }
        else {
            getDataFromChineseMedicines()
        }
        titleItem.title = medicineName
        
        self.view.addSubview(optionsTableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
    }
    
    func getDataFromChineseMedicines() {
        db.open()
        
        if let medicineResult = db.executeQuery("select * from chinese_medicine where id = ?", medicineID) {
            let fieldName = ["name", "annouce","category","content","efficacy","manual","preparations","store"]
            titles = ["【名称】", "【药品禁忌】", "【药品分类】", "【临床成分】", "【药品疗效】", "【使用说明】", "【制剂与规格】", "【成人用量】", ]
            while(medicineResult.next()) {
                for field in fieldName {
                    let information = medicineResult.stringForColumn(field)
                    contents.append(information)
                }
            }
        }
        
        db.close()
    }
    
    func getDataFromWestMedicines() {
        db.open()
        
        if let medicineResult = db.executeQuery("select * from west_medicine where id = ?", medicineID) {
            let fieldName = ["name", "other_name", "ADRS", "content", "current_application", "dose_explain", "interaction", "manual", "pharmacolo", "preparations", "warn"]
            titles = ["【名称】", "【其它名称】", "【不良反应】", "【药品成分】", "【临床应用】", "【使用说明】", "【药物相互作用】", "【成人用量】", "【药效学】", "【制剂与规格】", "【注意事项】"]
            while(medicineResult.next()) {
                for field in fieldName {
                    let information = medicineResult.stringForColumn(field)
                    contents.append(information)
                }
            }
        }
        
        db.close()
    }
    
    func getTitle(information: String) -> (String, Int) {
        
        var index = 0
        
        for character in information.characters {
            index++
            if (character == "：" || character == "］") {
                break
            }
        }
        let subStr = information.substringToIndex(information.startIndex.advancedBy(index))
        return (subStr, index)
    }

    
    @IBAction func showOrHideMenu(sender: UIButton) {
        if !menuIsShow {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.optionsTableView.frame.origin.x = self.view.frame.width - 135.0
            })
        }
        else {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.optionsTableView.frame.origin.x = self.view.frame.width + 5
            })
        }
        menuIsShow = !menuIsShow
    }

}

extension MedicineDetailController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView.tag == 501 {
            let cell = tableView.dequeueReusableCellWithIdentifier("optionCell", forIndexPath: indexPath)
            cell.textLabel?.text = titles[indexPath.row]
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! DetailCell
        cell.titleLabel.text = titles[indexPath.row]
        cell.contentLabel.text = contents[indexPath.row]
        
        return cell
    }
}

extension MedicineDetailController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView.tag == 501 {
            detailTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        }
       
        if menuIsShow == true {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.optionsTableView.frame.origin.x = self.view.frame.width + 5
            })
            menuIsShow = false
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

