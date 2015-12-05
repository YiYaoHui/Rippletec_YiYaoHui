//
//  LastLevelMedicineController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/3.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class LastLevelMedicineController: UIViewController {
    
    
    @IBOutlet weak var lastLevelTableView: UITableView!
    
    var medicineType = ""
    var medicineParentID = ""
    
    let db = MedicineDB.sharedInstance()
    var lastLevelMedicines = [Medicine]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if medicineType == "西药" {
            getDataFromWestMedicines()
        }
        else {
            getDataFromChineseMedicines()
        }
        
        lastLevelTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func getDataFromChineseMedicines() {
        db.open()
        
        if let fourthLevelMedicineID = db.executeQuery("select id from medicine_type where parent_type_id = ?", medicineParentID) {
            while fourthLevelMedicineID.next() {
                let medicineTypeId = fourthLevelMedicineID.stringForColumn("id")
                if let lastLevelResults = db.executeQuery("select id, name from chinese_medicine where medicine_type_id = ?", medicineTypeId) {
                    while lastLevelResults.next() {
                        let id = lastLevelResults.stringForColumn("id")
                        let name = lastLevelResults.stringForColumn("name")
                        let medicine = Medicine(name: name, id: id)
                        lastLevelMedicines.append(medicine)
                    }
                }
            }
        }
        db.close()
    }
    
    func getDataFromWestMedicines() {
        db.open()

        if let lastLevelResults = db.executeQuery("select id, name from west_medicine where medicine_type_id = ?", medicineParentID) {
            while lastLevelResults.next() {
                let id = lastLevelResults.stringForColumn("id")
                let name = lastLevelResults.stringForColumn("name")
                let medicine = Medicine(name: name, id: id)
                lastLevelMedicines.append(medicine)
            }
        }
        
        db.close()
    }

}

extension LastLevelMedicineController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastLevelMedicines.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lastLevelCell", forIndexPath: indexPath)
        cell.textLabel?.text = lastLevelMedicines[indexPath.row].name
        return cell
    }
}

extension LastLevelMedicineController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

