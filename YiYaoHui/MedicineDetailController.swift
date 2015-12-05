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
    
    var medicineType = ""
    var medicineID = ""
    
    let db = MedicineDB.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTableView.tableFooterView = UIView(frame: CGRectZero)
    }

    func getMedicineData() {
        db.open()
        
        let databaseTable = medicineType == "西药" ? "west_medicine" : "chinese_medicine"
        
        if let medicineResult = db.executeQuery("select * from ? where medicine_type_id = ?", databaseTable, medicineID) {
        
        }
        
        db.close()
    }

}

extension MedicineDetailController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath)
        
        return cell
    }
}

extension MedicineDetailController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

