//
//  MedicineDB.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/2.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import Foundation

class MedicineDB {
    
    struct Static {
        static var instance: FMDatabase? = nil
        static var token:dispatch_once_t = 0
    }
    
    class func sharedInstance() -> FMDatabase! {
        dispatch_once(&Static.token) {
            
            
            let searchPath = NSURL(string: NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!)
            
            let mobileFilePath = searchPath!.URLByAppendingPathComponent("MedicineSQLite.db")
            
            if !NSFileManager.defaultManager().fileExistsAtPath("\(mobileFilePath)") {
                
                let filePath = NSBundle.mainBundle().pathForResource("MedicineSQLite", ofType: "db")
                print(filePath)
                
                try! NSFileManager.defaultManager().copyItemAtPath(filePath!, toPath: "\(mobileFilePath)")
            }
            
            Static.instance = FMDatabase(path: "\(mobileFilePath)")
            
        }
        return Static.instance!
    }
    
    
}