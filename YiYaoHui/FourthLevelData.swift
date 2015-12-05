//
//  FourthLevelData.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/2.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import Foundation

class FourthLevelData {
    
    var secondLevelData: SecondLevelData!
    var fourthLevelMedicins = [[Medicine]]()
    
    let db = MedicineDB.sharedInstance()
    
    init(secondLevelData: SecondLevelData, medicineType: String) {
        
        self.secondLevelData = secondLevelData
        
        getThirdLeveData()
        
    }
    
    func getThirdLeveData() {
        db.open()
        for item in secondLevelData.secondLevelMedicines {
            if let thirdLevelResults = db.executeQuery("select id, name from medicine_type where parent_type_id = ?", item.id) {
                var singleTypeMedicines = [Medicine]()
                while thirdLevelResults.next() {
                    let id = thirdLevelResults.stringForColumn("id")
                    let name = thirdLevelResults.stringForColumn("name")
                    let medicine = Medicine(name: name, id: id)
                    singleTypeMedicines.append(medicine)
                }
                fourthLevelMedicins.append(singleTypeMedicines)
            }
        }
        
        db.close()
    }
    
    func getFourthLevelData() {
        
        db.open()
        for item in secondLevelData.secondLevelMedicines {
            if let thirdLevelResults = db.executeQuery("select id from medicine_type where parent_type_id = ?", item.id) {
                var singleTypeMedicines = [Medicine]()
                while thirdLevelResults.next() {
                    let thirdLevelTypeID = thirdLevelResults.stringForColumn("id")
                    
                    if let fourthLevelResults = db.executeQuery("select id, name from medicine_type where parent_type_id = ?", thirdLevelTypeID) {
                        while fourthLevelResults.next() {
                            let id = fourthLevelResults.stringForColumn("id")
                            let name = fourthLevelResults.stringForColumn("name")
                            let medicine = Medicine(name: name, id: id)
                            singleTypeMedicines.append(medicine)
                        }
                    }
                }
                fourthLevelMedicins.append(singleTypeMedicines)
            }
        }
        
        db.close()
    }
    
}