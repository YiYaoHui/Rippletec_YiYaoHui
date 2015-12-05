//
//  SecondLevelMedicine.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/2.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import Foundation

struct Medicine {
    var name = ""
    var id = ""
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
}

class SecondLevelData {
    
    let db = MedicineDB.sharedInstance()
    
    var secondLevelMedicines = [Medicine]()
    var parentID = ""
    
    init(medicineType: String) {
        db.open()
        
        let result = db.executeQuery("select id from medicine_type where name='\(medicineType)'", withArgumentsInArray: nil)
        while result.next() {
            parentID = result.stringForColumn("id")

        }
        
        if let medicineResults = db.executeQuery("select id, name from medicine_type where parent_type_id=?", parentID) {
            while medicineResults.next() {
                let id = medicineResults.stringForColumn("id")
                let name = medicineResults.stringForColumn("name")
                let medicine = Medicine(name: name, id: id)
                secondLevelMedicines.append(medicine)
            }
        }
        
        db.close()
    }
}