//
//  MedicineListController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/11/30.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class MedicineListController: UIViewController {
    
    
    @IBOutlet weak var medicineTableView: UITableView!
    
    var medicineType = ""
    
    var secondLevelData: SecondLevelData!
    var fourthLevelData: FourthLevelData!
    var selectedMedicine: Medicine!
    
    var isExpand = [Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondLevelData = SecondLevelData(medicineType: medicineType)
        fourthLevelData = FourthLevelData(secondLevelData: secondLevelData, medicineType: medicineType)
        
        isExpand = [Bool](count: secondLevelData.secondLevelMedicines.count, repeatedValue: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("MedicineControllerAppear", object: nil, userInfo: ["medicineType": medicineType])
    }

}

extension MedicineListController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return secondLevelData.secondLevelMedicines.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isExpand[section] == true {
            return fourthLevelData.fourthLevelMedicins[section].count + 1
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("secondLevelCell", forIndexPath: indexPath) as! HeaderCell
            
            if isExpand[indexPath.section] {
                cell.stateImageView.image = UIImage(named: "close")
            }
            else {
                cell.stateImageView.image = UIImage(named: "expand")
            }
            
            cell.secondLevelLabel.text = secondLevelData.secondLevelMedicines[indexPath.section].name
            
            let singleTypeMedicines = fourthLevelData.fourthLevelMedicins[indexPath.section]
            var str = ""
            for medicine in singleTypeMedicines {
                str += medicine.name + " "
            }
            cell.fourthLevelLabel.text = str
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("fourthLevelCell", forIndexPath: indexPath)
        let fourthLevelLabel = cell.viewWithTag(501) as! UILabel
        let singleTypeMedicines = fourthLevelData.fourthLevelMedicins[indexPath.section]

        fourthLevelLabel.text = singleTypeMedicines[indexPath.row - 1].name
        
        return cell
        
    }
}

extension MedicineListController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            isExpand[indexPath.section] = !isExpand[indexPath.section]
            tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        else {
            let singleTypeMedicines = fourthLevelData.fourthLevelMedicins[indexPath.section]
            selectedMedicine = singleTypeMedicines[indexPath.row - 1]
            performSegueWithIdentifier("toLastLevel", sender: self)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toLastLevel" {
            let destinationVC = segue.destinationViewController as! LastLevelMedicineController
                destinationVC.medicineType = medicineType
                destinationVC.medicineParentID = selectedMedicine.id
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }
        return 44
    }
}
